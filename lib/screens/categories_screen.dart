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
                    widget.groupName != 'null' ? widget.groupName : 'SAMTUIT',
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
                        Tab(text: 'Teachers'),
                        Tab(text: 'Ilmiy Ishlar'),
                        Tab(text: 'Students'),
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
                    future: Provider.of<TeacherApi>(context, listen: false).fetchTeachers(),
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
                        teachers: Provider.of<TeacherApi>(context, listen: false).teachers,
                      );
                    },
                  ),
                  FutureBuilder(
                    future: Provider.of<HomeworkApi>(context, listen: false).getAllLessons(),
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
                        return AssignmentWidget(
                          lessons: Provider.of<HomeworkApi>(context, listen: false).lessons,
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: Provider.of<StudentApi>(context, listen: false).getAllStudent(),
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
                      return ListView.builder(
                        itemCount: Provider.of<StudentApi>(context, listen: false).students.length,
                        itemBuilder: (context, index) {
                          final student = Provider.of<StudentApi>(context, listen: false).students[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name: ${student.firstName} ${student.lastName}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Email: ${student.email}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Phone: ${student.phone}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
