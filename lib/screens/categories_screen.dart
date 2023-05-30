import 'package:codeacademy/models/student.dart';
import 'package:codeacademy/screens/add_student_screen.dart';
import 'package:codeacademy/screens/news_screen.dart';
import 'package:codeacademy/widgets/teacher_tap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/assignment_api.dart';
import '../providers/homework_api.dart';
import '../providers/student_api.dart';
import '../providers/teacher_api.dart';
import '../widgets/assignment_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/lesson_tap_widget.dart';
import '../widgets/student_tap_widget.dart';
import 'login_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final int id;
  final String groupName;
  const CategoriesScreen({super.key, required this.id, required this.groupName});
  static const routeName = 'categoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController tgUsername = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController github = TextEditingController();
  TextEditingController codewars = TextEditingController();
  List<bool> checkboxStates = [];

  @override
  void initState() {
    super.initState();
    // Initialize the checkbox states
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      animationDuration: const Duration(milliseconds: 100),
      child: Scaffold(
        key: _key,
        endDrawerEnableOpenDragGesture: false,
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _key.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.groupName != 'null' ? widget.groupName : 'CODEACADEMY',
                    style: GoogleFonts.monda(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 10),
                  const Spacer(),
                  const Expanded(
                    flex: 2,
                    child: TabBar(
                      dividerColor: Colors.grey,
                      indicatorColor: Colors.orange,
                      labelColor: Colors.orange,
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 119, 115, 115),
                      ),
                      tabs: [
                        Tab(text: 'Assignments'),
                        Tab(text: 'Students'),
                        Tab(text: 'Teachers'),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      context.goNamed(NewsScreen.routeName);
                    },
                    child: Badge(
                      label: const Text('1'),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[350],
                        child: Icon(
                          Icons.newspaper_rounded,
                          color: Colors.grey[700],
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      context.goNamed(LoginScreen.routeName);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[350],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[700],
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FutureBuilder(
                    future: Provider.of<HomeworkApi>(context, listen: false).getHomework(id: widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitThreeInOut(
                            color: Colors.black,
                            size: 30,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        Provider.of<AssignmentApi>(context, listen: false).nullAssignment();
                        return const Row(
                          children: [
                            LessonTapWidget(),
                            AssignmentWidget(),
                          ],
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: Provider.of<StudentApi>(context, listen: false).getStudent(groupId: widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      return ListView(
                        children: [
                          StudentTapWidget(
                            data: Provider.of<StudentApi>(context, listen: false).students,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ActionChip(
                                  label: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Add Student to Codeacademy'),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Create student'),
                                          content: Column(
                                            children: [
                                              TextField(
                                                controller: firstName,
                                                decoration: const InputDecoration(
                                                  hintText: 'First name*',
                                                ),
                                                onChanged: (value) {},
                                              ),
                                              TextField(
                                                controller: lastName,
                                                decoration: const InputDecoration(
                                                  hintText: 'Last name*',
                                                ),
                                                onChanged: (value) {},
                                              ),
                                              TextField(
                                                controller: phoneNumber,
                                                decoration: const InputDecoration(
                                                  hintText: 'Phone number*',
                                                ),
                                                onChanged: (value) {},
                                              ),
                                              TextField(
                                                controller: github,
                                                decoration: const InputDecoration(
                                                  hintText: 'Github username*',
                                                ),
                                                onChanged: (value) {},
                                              ),
                                              TextField(
                                                controller: codewars,
                                                decoration: const InputDecoration(
                                                  hintText: 'Codewars username',
                                                ),
                                                onChanged: (value) {},
                                              ),
                                              TextField(
                                                controller: email,
                                                decoration: const InputDecoration(
                                                  hintText: 'Email*',
                                                ),
                                                onChanged: (value) {},
                                              ),
                                              TextField(
                                                controller: tgUsername,
                                                decoration: const InputDecoration(
                                                  hintText: 'Telegram username*',
                                                ),
                                                onChanged: (value) {},
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Provider.of<StudentApi>(context, listen: false)
                                                    .createStudent(Student(
                                                  id: null,
                                                  firstName: firstName.text,
                                                  email: email.text,
                                                  gitHub: github.text,
                                                  lastName: lastName.text,
                                                  phone: phoneNumber.text,
                                                  codeWars: codewars.text,
                                                  tgUsername: tgUsername.text,
                                                ))
                                                    .then((value) {
                                                  if (value == 200 || value == 201) {
                                                    Navigator.of(context).pop();
                                                  } else {
                                                    Navigator.of(context).pop();
                                                    setState(() {});
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('$value'),
                                                      ),
                                                    );
                                                  }
                                                });
                                              },
                                              child: const Text('Create'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                              const SizedBox(width: 10),
                              FutureBuilder(
                                future: Provider.of<StudentApi>(context, listen: false).getAllStudent(),
                                builder: (context, snapshot) => ActionChip(
                                  label: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Add student this group'),
                                  ),
                                  onPressed: () {
                                    context.goNamed(AddStudentScreen.routeName, extra: {
                                      'groupId': '${widget.id}',
                                      'students': Provider.of<StudentApi>(context, listen: false).students,
                                      'id': widget.id,
                                    });
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) => StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                    //     return CustomDialog(groupId: widget.id);
                                    //   }),
                                    // );
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  FutureBuilder(
                    future: Provider.of<StudentApi>(context, listen: false).getStudent(groupId: widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      return TeacherWidget(
                        data: Provider.of<TeacherApi>(context, listen: false).teachers,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
