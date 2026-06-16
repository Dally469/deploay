import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequest {
  // Postman collection uses http://localhost:8585 as baseUrl.
  // Keep compatibility by letting the value be overridden from SharedPreferences.
  static const String _defaultBaseUrl = 'http://172.20.10.12:8585/api';
  static const Duration _requestTimeout = Duration(seconds: 20);

  final String _imageUrl = 'https://ralgaapi.awm-global.org/assets/pdf/';

  static const String _cacheFolderName = 'api_cache';

  String getImage() {
    return _imageUrl;
  }

  Future<String> _getBaseUrl() async {
    final localStorage = await SharedPreferences.getInstance();
    final configured = localStorage.getString('baseUrl');
    if (configured == null || configured.trim().isEmpty) {
      return _defaultBaseUrl;
    }
    return configured.trim();
  }

  Future<void> setBaseUrl(String baseUrl) async {
    final localStorage = await SharedPreferences.getInstance();
    await localStorage.setString('baseUrl', baseUrl.trim());
  }

  Future<String?> _readToken() async {
    final localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('token');
  }

  Map<String, String> _setHeaders({Map<String, String>? extraHeaders}) {
    final headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }
    return headers;
  }

  Uri _buildUri(String baseUrl, String apiPath, {Map<String, String>? query}) {
    final normalizedBase = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final normalizedPath = apiPath.startsWith('/') ? apiPath : '/$apiPath';
    return Uri.parse('$normalizedBase$normalizedPath').replace(
      queryParameters: query == null || query.isEmpty ? null : query,
    );
  }

  Future<Directory> _getCacheDirectory() async {
    final baseDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory('${baseDir.path}/$_cacheFolderName');
    if (!cacheDir.existsSync()) {
      cacheDir.createSync(recursive: true);
    }
    return cacheDir;
  }

  String _cacheFileName(String key) {
    return base64Url.encode(utf8.encode(key)).replaceAll('=', '');
  }

  Future<String?> _readCachedBody(String key) async {
    try {
      final dir = await _getCacheDirectory();
      final file = File('${dir.path}/${_cacheFileName(key)}.json');
      if (!file.existsSync()) {
        return null;
      }
      return await file.readAsString();
    } catch (_) {
      return null;
    }
  }

  Future<void> _writeCachedBody(String key, String body) async {
    try {
      final dir = await _getCacheDirectory();
      final file = File('${dir.path}/${_cacheFileName(key)}.json');
      await file.writeAsString(body, flush: true, mode: FileMode.write);
    } catch (_) {
      // Cache write should never break the request flow.
    }
  }

  Future<http.Response> _buildCachedResponse(String body,
      {String cacheStatus = 'HIT'}) async {
    return http.Response(
      body,
      200,
      headers: _setHeaders(extraHeaders: {'x-cache': cacheStatus}),
    );
  }

  Future<void> clearPublicCache() async {
    final dir = await _getCacheDirectory();
    if (dir.existsSync()) {
      await dir.delete(recursive: true);
    }
  }

  Future<http.Response> _request(
    String method,
    String apiPath, {
    Object? data,
    bool useTokenAsQuery = false,
    bool enableOfflineCache = false,
    bool preferCachedFirst = false,
    bool forceRefresh = false,
    String? cacheKey,
    Map<String, String>? query,
    Map<String, String>? headers,
  }) async {
    String? resolvedCacheKey;
    try {
      final baseUrl = await _getBaseUrl();
      final allQuery = <String, String>{...?query};

      if (useTokenAsQuery) {
        final token = await _readToken();
        if (token != null && token.isNotEmpty) {
          allQuery['token'] = token;
        }
      }

      final uri = _buildUri(baseUrl, apiPath, query: allQuery);
      final allHeaders = _setHeaders(extraHeaders: headers);
      resolvedCacheKey = cacheKey ?? uri.toString();

      switch (method.toUpperCase()) {
        case 'GET':
          if (enableOfflineCache && preferCachedFirst && !forceRefresh) {
            final cachedBody = await _readCachedBody(resolvedCacheKey);
            if (cachedBody != null && cachedBody.isNotEmpty) {
              return _buildCachedResponse(cachedBody, cacheStatus: 'HIT');
            }
          }

          final response = await http
              .get(uri, headers: allHeaders)
              .timeout(_requestTimeout);

          if (enableOfflineCache && response.statusCode == 200) {
            await _writeCachedBody(resolvedCacheKey, response.body);
          }

          if (enableOfflineCache && response.statusCode != 200) {
            final fallback = await _readCachedBody(resolvedCacheKey);
            if (fallback != null && fallback.isNotEmpty) {
              return _buildCachedResponse(fallback, cacheStatus: 'STALE');
            }
          }

          return response;
        case 'POST':
          return http
              .post(uri, headers: allHeaders, body: jsonEncode(data))
              .timeout(_requestTimeout);
        case 'PUT':
          return http
              .put(uri, headers: allHeaders, body: jsonEncode(data))
              .timeout(_requestTimeout);
        case 'DELETE':
          return http
              .delete(uri, headers: allHeaders)
              .timeout(_requestTimeout);
        default:
          return http.Response(
            jsonEncode({'message': 'Unsupported HTTP method: $method'}),
            405,
            headers: _setHeaders(),
          );
      }
    } on TimeoutException {
      if (method.toUpperCase() == 'GET' &&
          enableOfflineCache &&
          resolvedCacheKey != null) {
        final fallback = await _readCachedBody(resolvedCacheKey);
        if (fallback != null && fallback.isNotEmpty) {
          return _buildCachedResponse(fallback, cacheStatus: 'STALE');
        }
      }
      return http.Response(
        jsonEncode({'message': 'Request timeout'}),
        408,
        headers: _setHeaders(),
      );
    } catch (e) {
      if (method.toUpperCase() == 'GET' &&
          enableOfflineCache &&
          resolvedCacheKey != null) {
        final fallback = await _readCachedBody(resolvedCacheKey);
        if (fallback != null && fallback.isNotEmpty) {
          return _buildCachedResponse(fallback, cacheStatus: 'STALE');
        }
      }
      return http.Response(
        jsonEncode({'message': 'Request failed', 'error': e.toString()}),
        500,
        headers: _setHeaders(),
      );
    }
  }

  // Legacy helpers (kept for existing app screens)
  Future<http.Response> postData(dynamic data, String apiUrl) async {
    return _request('POST', apiUrl, data: data, useTokenAsQuery: true);
  }

  Future<http.Response> getData(String apiUrl) async {
    return _request('GET', apiUrl, useTokenAsQuery: true);
  }

  Future<http.Response> getPublicData(
    String apiUrl, {
    bool forceRefresh = false,
    String? cacheKey,
  }) async {

        debugPrint("API URL: $apiUrl, Force Refresh: $forceRefresh");
    return _request(
      'GET',
      apiUrl,
      enableOfflineCache: true,
      preferCachedFirst: true,
      forceRefresh: forceRefresh,
      cacheKey: cacheKey,
    );
  }

  // Postman collection APIs
  Future<http.Response> getAllArticles() => _request('GET', '/api/articles');
  Future<http.Response> getArticleById(int id) =>
      _request('GET', '/api/articles/$id');
  Future<http.Response> createArticle(Map<String, dynamic> payload) =>
      _request('POST', '/api/articles', data: payload);
  Future<http.Response> updateArticle(int id, Map<String, dynamic> payload) =>
      _request('PUT', '/api/articles/$id', data: payload);
  Future<http.Response> deleteArticle(int id) =>
      _request('DELETE', '/api/articles/$id');
  Future<http.Response> getArticlesByLanguage(String lang) =>
      _request('GET', '/api/articles/lang/$lang');

  Future<http.Response> getAllCategories() =>
      _request('GET', '/api/categories');
  Future<http.Response> getCategoryById(int id) =>
      _request('GET', '/api/categories/$id');
  Future<http.Response> createCategory(Map<String, dynamic> payload) =>
      _request('POST', '/api/categories', data: payload);
  Future<http.Response> updateCategory(
          int id, Map<String, dynamic> payload) =>
      _request('PUT', '/api/categories/$id', data: payload);
  Future<http.Response> deleteCategory(int id) =>
      _request('DELETE', '/api/categories/$id');
  Future<http.Response> getCategoriesByLanguage(String lang) =>
      _request('GET', '/api/categories/lang/$lang');

  Future<http.Response> getAllChapters() => _request('GET', '/api/chapters');
  Future<http.Response> getChapterById(int id) =>
      _request('GET', '/api/chapters/$id');
  Future<http.Response> createChapter(Map<String, dynamic> payload) =>
      _request('POST', '/api/chapters', data: payload);
  Future<http.Response> updateChapter(int id, Map<String, dynamic> payload) =>
      _request('PUT', '/api/chapters/$id', data: payload);
  Future<http.Response> deleteChapter(int id) =>
      _request('DELETE', '/api/chapters/$id');
  Future<http.Response> getChaptersByLanguage(String lang) =>
      _request('GET', '/api/chapters/lang/$lang');

  // Optional authenticated access point for future profile endpoint usage.
  Future<http.Response> getUser(String apiUrl) async {
    return _request('GET', apiUrl, useTokenAsQuery: true);
  }
}
