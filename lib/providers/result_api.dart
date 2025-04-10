import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/result.dart';

class ResultApi with ChangeNotifier {
  List<Result> _allResults = [];
  List<Result> get allResult {
    return [..._allResults];
  }

  Future<void> getResult(int lessonId, int assignmentId) async {
    Uri url = Uri(
      scheme: 'http',
      host: '192.168.100.2',
      port: 8000,
      path: 'lesson/result/',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json;  charset=utf-8',
      },
      body: jsonEncode(
        {
          "lesson": lessonId,
          "assignment": assignmentId,
        },
      ),
    );
    List data = jsonDecode(response.body);
    _allResults = data.map((e) => Result.getResult(e)).toList();
    _allResults.sort(
      (a, b) {
        if (a.rightAnswers == b.rightAnswers) {
          return a.attempt.compareTo(b.rightAnswers);
        }
        return b.rightAnswers.compareTo(a.rightAnswers);
      },
    );
    notifyListeners();
  }
}
