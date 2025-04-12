import 'package:codeacademy/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/teacher.dart';

class TeacherApi with ChangeNotifier {
  List<Teacher> _teachers = [];

  List<Teacher> get teachers {
    return _teachers;
  }

  Future<void> fetchTeachers() async {
    print('Fetching teachers...');
    final url = Uri.parse('$baseUrl/get-all-teacher/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(data);
        _teachers = data.map((json) => Teacher.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load teachers');
      }
    } catch (error) {
      // Handle error (e.g., log it or show a message)
      rethrow;
    }
  }

  void deleteTeacher(int id) {
    _teachers.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void addTeacher(Teacher teacher) {
    _teachers.add(teacher);
    notifyListeners();
  }
}
