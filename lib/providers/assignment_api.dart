import 'dart:convert';

import 'package:codeacademy/constants/constants.dart';
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
    String path = 'lesson/assignment/all/$id';
    Uri url = Uri.parse('$baseUrl$path'); // Using baseUrl constant
    try {
      final response = await http.get(url);
      List data = jsonDecode(response.body);
      _allAssignment = data.map((e) => Assignment.getAssignment(e)).toList();
      _lessonId = id;
      notifyListeners();
    } catch (e) {
      print("error assignment: $e");
    }
  }

  addAssingment(Assignment assignment) {
    _allAssignment?.add(assignment);
    notifyListeners();
  }

  addItemAsDemo(Assignment assignment) {
    demoAssignment.add(assignment);
    notifyListeners();
  }
}
