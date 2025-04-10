import 'dart:convert';

import 'package:codeacademy/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/lesson.dart';


class HomeworkApi with ChangeNotifier {
  List<Lesson> _homeworks = [];
  List<Lesson> get homeworks {
    return _homeworks;
  }

  Future<void> getHomework({required int id}) async {
    String path = 'lesson/get/$id/';
    Uri url = Uri.parse('$baseUrl$path'); // Using baseUrl constant
    try {
      http.Response response = await http.get(url);

      List dataFromJson = jsonDecode(response.body);
      _homeworks = dataFromJson.map((e) => Lesson.getLesson(e)).toList();
    } catch (_) {
      rethrow;
    }
    notifyListeners();
  }
}
