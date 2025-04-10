import 'dart:convert';

import 'package:codeacademy/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApi with ChangeNotifier {
  List<Course> _courses = [];
  List<Course> get courses {
    return [..._courses];
  }

  Future<void> getCourse() async {
    print('getting course');
    Uri url = Uri.parse('$baseUrl/course/');
    try {
      http.Response response = await http.get(url);
      List dataFromJson = jsonDecode(response.body);
      _courses = dataFromJson.map((e) => Course.getCourse(e)).toList();
      notifyListeners();
    } catch (e) {
      print('error $e');
    }
  }
}
