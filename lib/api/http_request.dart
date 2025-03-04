import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class HttpRequest {
  final String _url = 'http://85.239.242.194:8585/';
  final String _imageUrl = 'https://ralgaapi.awm-global.org/assets/pdf/';

  getImage(){
    return _imageUrl;
  }
  postData(data, apiUrl) async{
    var fullUrl = _url + apiUrl + await _getToken();

    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  getData(apiUrl) async{
    var fullUrl = _url + apiUrl + await _getToken();

    return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders()
    );
  }

  _getToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token = $token';
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };


  getUser(apiurl) async {

  }

  getPublicData(apiurl) async {
    http.Response response = await http.get(Uri.parse(_url+apiurl));
    try {
      if(response.statusCode == 200){
        return response;
      }else{
        return 'failed';
      }
    }catch(e){
      print(e);
      return 'failed';
    }
  }
}
