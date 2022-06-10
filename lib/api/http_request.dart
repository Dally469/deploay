import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class HttpRequest {
  final String _url = 'https://rwtest.yesconnect.rw/';
  final String _imageUrl = 'https://rwtest.yesconnect.rw/assets/pdf/';
   //final String _url = 'http://192.168.8.105/YesConnectAPI/public/';
  // final String _imageUrl = 'http://192.168.8.105/YesConnectAPI/public/assets/images/';
  //  final String _url = 'http://localhost:8084/';
  //  final String _imageUrl = 'http://localhost:8084/assets/images/';

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
