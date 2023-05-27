import 'package:flutter/material.dart';

import '../models/teacher.dart';

class TeacherApi with ChangeNotifier {
  final List<Teacher> _teachers = [
    Teacher(
      id: 1,
      firstName: "Zarifjon",
      lastName: "Naxalov",
      email: "naxalovzarif@gmail.com",
      phone: "+998933339899",
      gitHub: "ZarifNaxalov",
      jobTitle: "AI Researcher",
    ),
    Teacher(
      id: 2,
      firstName: "Sanjarbek",
      lastName: "Saidov",
      email: "sanjarbeksaidov@gmail.com",
      phone: "+998904642625",
      gitHub: "Sanjarbek17",
      jobTitle: "Flutter Developer",
    ),
    Teacher(
      id: 3,
      firstName: "Javohir",
      lastName: "Jalilov",
      email: "javohirjalilov@gmail.com",
      phone: "+998943577744",
      gitHub: "JalilovJavohir",
      jobTitle: "AI Researcher",
    ),
    Teacher(
      id: 4,
      firstName: "Diyorbek",
      lastName: "Djumanov",
      email: "diyorbekjumanov@gmail.com",
      phone: "+998945344334",
      gitHub: "DjumanovDiyorbek",
      jobTitle: "Backend Developer",
    ),
    Teacher(
      id: 5,
      firstName: "Ikrom",
      lastName: "Yusupov",
      email: "ikromyusupov@gmail.com",
      phone: "+998939761176",
      gitHub: "IkromYusupov",
      jobTitle: "AI Researcher",
    ),
  ];
  List<Teacher> get teachers {
    return _teachers;
  }

  deleteTeacher(int id) {
    _teachers.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  addTeacher(Teacher teacher) {
    _teachers.add(teacher);
    notifyListeners();
  }
}
