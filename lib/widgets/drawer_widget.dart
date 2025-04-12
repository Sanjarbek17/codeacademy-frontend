import 'package:codeacademy/constants/samtuit_logo.dart';
import 'package:codeacademy/providers/teacher_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/course_api.dart';
import '../screens/categories_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<CourseApi>(context, listen: false).courses;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.network(logo),
          ),
          ExpansionPanelList.radio(
            children: courses
                .map(
                  (categoryItem) => ExpansionPanelRadio(
                    canTapOnHeader: true,
                    value: categoryItem,
                    headerBuilder: (context, isExpanded) => ListTile(
                      title: Text(categoryItem.name),
                      leading: const Icon(Icons.payment),
                    ),
                    body: SubCategory(
                      id: categoryItem.id,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class SubCategory extends StatefulWidget {
  final int id;

  const SubCategory({
    super.key,
    required this.id,
  });

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    final teachers = Provider.of<TeacherApi>(context, listen: false).teachers;
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          final teacher = teachers[index];
          return ListTile(
            title: Text(
              '${teacher.firstName} ${teacher.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone: ${teacher.phone ?? "N/A"}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Email: ${teacher.email ?? "N/A"}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            onTap: () async {
              Navigator.of(context).pop();
              context.goNamed(
                CategoriesScreen.routeName,
                pathParameters: {
                  'id': teacher.id.toString(),
                },
                extra: '${teacher.firstName} ${teacher.lastName}',
              );
            },
          );
        },
      ),
    );
  }
}
