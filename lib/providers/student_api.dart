// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/student.dart';

class StudentApi with ChangeNotifier {
  List<Student> _students = [];
  List<Student> get students {
    return _students;
  }

  Future<void> getStudent({int? groupId}) async {
    String path = groupId != null ? '/get-students-from-group/$groupId/' : 'student/all/';
    Uri url = Uri(
      scheme: 'https',
      host: 'lmsapi.pythonanywhere.com',
      path: path,
    );

    http.Response response = await http.get(url);
    // print(response.body);

    List dataFromJson = jsonDecode(response.body);

    _students = dataFromJson.map((e) => Student.getStudent(e)).toList();
    // print(_students);
    notifyListeners();
  }

  Future<Map> deleteStudent({int? studentId}) async {
    String path = 'student/delete/$studentId/';
    Uri url = Uri(
      scheme: 'https',
      host: 'codeschooluzapi.pythonanywhere.com',
      path: path,
    );

    http.Response response = await http.post(url);
    Map dataFromJson;
    if (response.statusCode == 200) {
      dataFromJson = jsonDecode(response.body);
      return dataFromJson;
    } else {
      dataFromJson = {'status': response.reasonPhrase};
      return dataFromJson;
    }
  }

  Future<void> updateStudent({int? studentId, required Map content}) async {
    String path = 'student/delete/$studentId/';
    Uri url = Uri(
      scheme: 'https',
      host: 'codeschooluzapi.pythonanywhere.com',
      path: path,
    );
    Map<String, String> body = {
      'first_name': content['first_name'],
      'last_name': content['last_name'],
      'phone': content['phone'],
      'email': content['email'],
      'github': content['github'],
      'codewars': content['codewars'],
      'tg_username': content['tg_username'],
    };

    http.Response response = await http.post(url);
  }
}
