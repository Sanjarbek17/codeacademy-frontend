import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/teacher.dart';
import '../providers/teacher_api.dart';

class TeacherWidget extends StatefulWidget {
  final List<Teacher> data;
  const TeacherWidget({super.key, this.data = const []});

  @override
  State<TeacherWidget> createState() => _TeacherWidgetState();
}

class _TeacherWidgetState extends State<TeacherWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.data.isNotEmpty
        ? Center(
            child: SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                child: ExpansionPanelList.radio(
                  children: widget.data
                      .map(
                        (teacher) => ExpansionPanelRadio(
                          canTapOnHeader: true,
                          value: teacher,
                          headerBuilder: (context, isExpanded) => ListTile(
                            title: Text(teacher.lastName),
                            subtitle: Text(teacher.firstName),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                Provider.of<TeacherApi>(context, listen: false).deleteTeacher(teacher.id).then((value) {
                                  setState(() {
                                    if (value['status'] == 'teacher deleted') {
                                      setState(() {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('teacher deleted')));
                                        print('teacher deleted');
                                      });
                                    } else {
                                      setState(() {
                                        print(value['status']);
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value['status'].toString())));
                                      });
                                    }
                                  });
                                });
                              },
                            ),
                          ),
                          body: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Teacher: ${teacher.firstName} ${teacher.lastName}\'s info!',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text('Email: ${teacher.email}'),
                                  const SizedBox(height: 10),
                                  Text('Phone: ${teacher.phone}'),
                                  const SizedBox(height: 10),
                                  Text('Job: ${teacher.jobTitle}'),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        : const Center(
            child: Text('This group does not have teachers'),
          );
  }
}
