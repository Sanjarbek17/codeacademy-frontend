// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:codeacademy/models/assignment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/lesson.dart';
import '../providers/assignment_api.dart';
import '../providers/homework_api.dart';

class LessonTapWidget extends StatefulWidget {
  const LessonTapWidget({super.key});

  @override
  State<LessonTapWidget> createState() => _LessonTapWidgetState();
}

class _LessonTapWidgetState extends State<LessonTapWidget> {
  int generateId() {
    var uuid = Random();
    return uuid.nextInt(999999);
  }

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _linkController = TextEditingController();

  final TextEditingController _typeController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Lesson> data = Provider.of<HomeworkApi>(context, listen: false).homeworks;
    List<Assignment>? assignments = Provider.of<AssignmentApi>(context, listen: false).demoAssignment;
    return Flexible(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white54,
        ),
        child: Column(
          children: [
            const Text(
              'Lessons',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(
                    data[index].name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 110, 109, 109),
                    ),
                  ),
                  onTap: () async {
                    Provider.of<AssignmentApi>(context, listen: false).onVisible(false);
                    await Provider.of<AssignmentApi>(context, listen: false).getAssignments(data[index].id);
                  },
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: (assignments).length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(
                    (assignments)[index].name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 110, 109, 109),
                    ),
                  ),
                  onTap: () async {},
                ),
              ),
            ),
            ActionChip(
              label: const Text('Add lesson'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Add lesson'),
                    content: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        TextField(
                          controller: _linkController,
                          decoration: const InputDecoration(
                            labelText: 'Link',
                          ),
                        ),
                        TextField(
                          controller: _typeController,
                          decoration: const InputDecoration(
                            labelText: 'Type',
                          ),
                        ),
                        TextField(
                          controller: _descController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
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
                          setState(() {
                            Provider.of<AssignmentApi>(context, listen: false).addItemAsDemo(
                              Assignment(
                                id: generateId(),
                                courseId: 1,
                                name: _nameController.text,
                                link: _linkController.text,
                                type: _typeController.text,
                                description: _descController.text,
                              ),
                            );
                            _descController.clear();
                            _linkController.clear();
                            _nameController.clear();
                            _typeController.clear();
                          });
                          debugPrint(Provider.of<AssignmentApi>(context, listen: false).demoAssignment.toString());
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
