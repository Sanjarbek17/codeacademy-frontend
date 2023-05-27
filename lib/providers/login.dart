import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login with ChangeNotifier {
  Future<String> login({required String username, required String password}) async {
    String path = 'login/';
    Uri url = Uri(
      scheme: 'https',
      host: 'lmsapi.pythonanywhere.com',
      path: path,
    );
    Map<String, String> headers = {
      'Authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
    };
    http.Response response = await http.get(url, headers: headers);
    Map dataFromJson = jsonDecode(response.body);
    return dataFromJson['message'] == null ? dataFromJson['detail'] : dataFromJson['message'];
  }
}
