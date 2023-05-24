import 'package:flutter/material.dart';

class Teacher with ChangeNotifier {
  String firstName;
  String lastName;
  String email;
  String phone;
  String gitHub;
  int id;
  String jobTitle;
  Teacher({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gitHub,
    required this.jobTitle,
  });

  factory Teacher.getStudent(Map data) {
    return Teacher(
      id: data['id'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      gitHub: data['github'],
      email: data['email'],
      phone: data['phone'],
      jobTitle: data['job_title'],
    );
  }
}
