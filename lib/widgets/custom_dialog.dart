// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_api.dart';

class CustomDialog extends StatefulWidget {
  int groupId;
  CustomDialog({super.key, required this.groupId});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  List<bool> checkboxStates = [];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add student to this group'),
      content: SizedBox(
        height: 400,
        width: 300,
        child: FutureBuilder(
          future: Provider.of<StudentApi>(context, listen: false).getAllStudent(),
          builder: (context, snapshot) {
            final students = Provider.of<StudentApi>(context, listen: false).students;
            List<bool> checkboxStates = List.generate(students.length, (index) => false); // Initialize the checkbox states

            return ListView.builder(
              shrinkWrap: true,
              itemCount: students.length,
              itemBuilder: (context, index) => CheckboxListTile(
                value: checkboxStates[index],
                title: Text(students[index].firstName),
                onChanged: (value) {
                  setState(() {
                    checkboxStates[index] = value!;
                  });
                },
              ),
            );
          },
        ),
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
            final students = Provider.of<StudentApi>(context, listen: false).students;
            List<int> selectedStudentIds = [];
            for (int i = 0; i < checkboxStates.length; i++) {
              if (checkboxStates[i]) {
                selectedStudentIds.add(students[i].id!);
              }
            }

            Provider.of<StudentApi>(context, listen: false).addStudentToGroup(
              groupId: widget.groupId,
              studentIds: selectedStudentIds,
            );
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
