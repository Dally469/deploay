import 'dart:convert';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/article_model.dart';
import 'package:ralga/utils/colors.dart';

class LawsRW extends StatefulWidget {
  final String id;
  final String title;

  const LawsRW(this.id, this.title, {Key? key}) : super(key: key);

  @override
  State<LawsRW> createState() => _LawsRWState();
}

class _LawsRWState extends State<LawsRW> {
  List<Article> laws = [];
  bool _isLoading = true;
  String? _errorMessage;
  int _expandedIndex = -1;
  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData({bool forceRefresh = false}) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    final String fileName = '${widget.id}_articleDataRW_v2.json';
    final Directory dir = await getTemporaryDirectory();
    final File file = File('${dir.path}/$fileName');

    try {
      if (!forceRefresh && file.existsSync()) {
        final String jsonData = file.readAsStringSync();
        final decoded = json.decode(jsonData);
        if (mounted) {
          setState(() {
            laws = Article.listFromResponse(decoded);
            _sortArticlesById();           // ← Sort here
            _isLoading = false;
          });
        }
      } else {
        final response = await HttpRequest().getPublicData(
          'articles/chapter/${widget.id}',
          forceRefresh: forceRefresh,
          cacheKey: 'laws_rw_${widget.id}_v1',
        );

        if (response.statusCode == 200) {
          final decoded = json.decode(response.body);
          if (mounted) {
            setState(() {
              laws = Article.listFromResponse(decoded);
              _sortArticlesById();           // ← Sort here
              _isLoading = false;
            });
          }
          await file.writeAsString(response.body,
              flush: true, mode: FileMode.write);
        } else {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _errorMessage =
                  'Byanze kugarura amategeko (${response.statusCode}).';
            });
          }
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Ntibishobotse kugarura amategeko. Ongera ugerageze.';
        });
      }
    }
  }


    void _sortArticlesById() {
    laws.sort((a, b) {
      final int numA = _extractArticleNumber(a.title);
      final int numB = _extractArticleNumber(b.title);
      return numA.compareTo(numB);
    });
  }

  // Helper to extract number from title like "Ingingo ya 13: ..."
  int _extractArticleNumber(String title) {
    final RegExp regex = RegExp(r'Ingingo ya (\d+)');
    final match = regex.firstMatch(title);
    if (match != null && match.groupCount >= 1) {
      return int.tryParse(match.group(1)!) ?? 0;
    }
    // Fallback to id if no number found in title
    return int.tryParse(title) ?? 0;  // Note: 'title' should be the parameter, but we'll adjust below
  }

  PreferredSizeWidget _appBar(double height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 82),
        child: Container(
          height: height + 82,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [appDarkColor, Color(0xFF008C8B)],
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 8, top: 26),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 22),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: whiteColor,
                            size: 19,
                          ),
                          splashRadius: 20,
                        ),
                        Expanded(
                          child: Text(
                            widget.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      _buildHeaderIcon(
                        icon: Icons.refresh_rounded,
                        onTap: () => _initData(forceRefresh: true),
                      ),
                      // _buildHeaderIcon(icon: Icons.tune_rounded, onTap: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildHeaderIcon(
      {required IconData icon, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        icon: Icon(icon, color: whiteColor, size: 20),
        onPressed: onTap,
        splashRadius: 20,
      ),
    );
  }

  Widget _buildLawsItem(int index) {
    final Article item = laws[index];
    final String content =
        item.law.isEmpty ? '<p>Nta bisobanuro biboneka.</p>' : item.law;
    final bool isExpanded = _expandedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedIndex = isExpanded ? -1 : index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          border: Border.all(
            color: isExpanded
                ? appDarkColor.withOpacity(0.3)
                : const Color(0xFFE6EDF2),
            width: isExpanded ? 1.5 : 1.0,
          ),
          boxShadow: isExpanded
              ? [
                  BoxShadow(
                      color: appDarkColor.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4))
                ]
              : [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2))
                ],
        ),
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Rwanda logo with subtle background
                  Container(
                    height: 36,
                    width: 36,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4F8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/images/rwlogo.png',
                        fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 12),
                  // Title
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: appDarkColor,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Expand/collapse icon
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color:
                            isExpanded ? appDarkColor : const Color(0xFFF0F4F8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: isExpanded ? Colors.white : appDarkColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Divider (only when expanded) ────────────────
            if (isExpanded)
              const Divider(height: 1, thickness: 1, color: Color(0xFFEEF2F6)),

            // ── Expanded content ─────────────────────────────
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HTML content
                    HtmlWidget(
                      content,
                      textStyle: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4A5568),
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      backgroundColor: const Color(0xFFF6F8F9),
      body: _isLoading
          ? const Center(
              child: SpinKitDoubleBounce(
                color: appColor,
                size: 70,
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => _initData(forceRefresh: true),
                          child: const Text('Ongera ugerageze'),
                        ),
                      ],
                    ),
                  ),
                )
              : laws.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Nta mategeko ahari.',
                              style: TextStyle(color: Colors.black54),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => _initData(forceRefresh: true),
                              child: const Text('Ongera usubize'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 16),
                      itemCount: laws.length,
                      itemBuilder: (context, index) => _buildLawsItem(index),
                    ),
    );
  }
}
