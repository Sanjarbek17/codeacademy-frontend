import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/assignment.dart';

class AssignmentApi with ChangeNotifier {
  List<Assignment> demoAssignment = [];
  List<Assignment>? _allAssignment;
  int _lessonId = 0;
  bool _resultVisible = false;

  bool get resultVisible {
    return _resultVisible;
  }

  int get lessonId {
    return _lessonId;
  }

  List<Assignment>? get allAssignment {
    return _allAssignment;
  }

  void onVisible(bool a) {
    _resultVisible = a;
  }

  void nullAssignment() {
    _allAssignment = null;
  }

  Future<void> getAssignments(int id) async {
    Uri url = Uri(scheme: 'https', host: 'lmsapi.pythonanywhere.com', path: 'lesson/assignment/$id/');
    final response = await http.get(url);
    List data = jsonDecode(response.body);
    _allAssignment = data.map((e) => Assignment.getAssignment(e)).toList();
    _lessonId = id;
    notifyListeners();
  }

  addItemAsDemo(Assignment assignment) {
    demoAssignment.add(assignment);
    notifyListeners();
  }
}
