// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';
import '../providers/student_api.dart';

class AddStudentScreen extends StatefulWidget {
  List<Student> students;
  int groupId;
  AddStudentScreen({super.key, required this.groupId, required this.students});
  static const routeName = 'add-student-to-group';

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  List<bool> checkboxStates = [];

  @override
  void initState() {
    super.initState();
    checkboxStates = List.generate(widget.students.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 30),
            child: Text(
              'Add Student to this group',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.students.length,
            itemBuilder: (context, index) => ListTile(
              leading: Checkbox(
                value: checkboxStates[index],
                onChanged: (value) {
                  setState(() {
                    checkboxStates[index] = value!;
                  });
                },
              ),
              title: Text('${widget.students[index].firstName} ${widget.students[index].lastName}'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final students = Provider.of<StudentApi>(context, listen: false).students;
          List<int> selectedStudentIds = [];
          for (int i = 0; i < checkboxStates.length; i++) {
            if (checkboxStates[i]) {
              selectedStudentIds.add(students[i].id!);
            }
          }

          Provider.of<StudentApi>(context, listen: false)
              .addStudentToGroup(
            groupId: widget.groupId,
            studentIds: selectedStudentIds,
          )
              .then(
            (value) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Students added')),
              );
            },
          );
        },
        label: const Text('Add students'),
      ),
    );
  }
}
