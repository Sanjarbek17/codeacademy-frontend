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

  Future<void> getAllStudent() async {
    String path = 'student/all/';
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

  // create function that will add student to the group
  Future<int> addStudentToGroup({required int groupId, required List<int> studentIds}) async {
    // var headers = {'Content-Type': 'application/json'};
    // var request = http.Request('POST', Uri.parse('https://lmsapi.pythonanywhere.com/add-students-to-group/$groupId/'));
    // request.body = json.encode({"students": studentIds});
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
    var headers = {'Content-Type': 'application/json'};
    String path = 'add-students-to-group/$groupId/';
    Uri url = Uri(
      scheme: 'https',
      host: 'lmsapi.pythonanywhere.com',
      path: path,
    );
    Map<String, List<int>> body = {
      "students": studentIds,
    };
    http.Response response = await http.post(url, body: json.encode(body), headers: headers);
    print(response.statusCode);
    print(response.reasonPhrase);
    return response.statusCode;
  }

  Future<int> createStudent(Student item) async {
    var headers = {'Content-Type': 'application/json'};
    String path = 'student/add/';
    Uri url = Uri(
      scheme: 'https',
      host: 'lmsapi.pythonanywhere.com',
      path: path,
    );
    Map body = {
      "first_name": item.firstName,
      "last_name": item.lastName,
      "github": item.gitHub,
      "codewars": item.codeWars,
      "phone": item.phone,
      "email": item.email,
      "tg_username": item.tgUsername,
    };
    http.Response response = await http.post(url, body: json.encode(body), headers: headers);
    return response.statusCode;
  }

  Future<Map> deleteStudent({int? studentId}) async {
    String path = 'student/delete/$studentId/';
    Uri url = Uri(
      scheme: 'https',
      host: 'lmsapi.pythonanywhere.com',
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
      host: 'lmsapi.pythonanywhere.com',
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
