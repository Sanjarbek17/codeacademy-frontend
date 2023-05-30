import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/assignment.dart';
import '../providers/assignment_api.dart';
import '../screens/result_screen.dart';

class AssignmentWidget extends StatefulWidget {
  const AssignmentWidget({super.key});

  @override
  State<AssignmentWidget> createState() => _AssignmentWidgetState();
}

class _AssignmentWidgetState extends State<AssignmentWidget> {
  int _index = 0;

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
    return Flexible(
      flex: 4,
      child: Consumer<AssignmentApi>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white54,
              ),
              child: value.allAssignment == null
                  ? const Center(
                      child: Text('Please choose lesson!'),
                    )
                  : Stack(
                      children: [
                        ListView.builder(
                            itemCount: value.allAssignment!.length + 1,
                            itemBuilder: (context, index) {
                              debugPrint(index.toString());
                              if (index == value.allAssignment!.length) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ActionChip(
                                      label: const Text('Add assignment'),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Add assignment'),
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
                                                    Provider.of<AssignmentApi>(context, listen: false).addAssingment(
                                                      Assignment(
                                                        id: generateId(),
                                                        courseId: 1,
                                                        name: _nameController.text,
                                                        link: _linkController.text,
                                                        type: _typeController.text,
                                                        description: _descController.text,
                                                      ),
                                                    );
                                                    _nameController.clear();
                                                    _linkController.clear();
                                                    _typeController.clear();
                                                    _descController.clear();
                                                  });
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
                                );
                              }
                              return Card(
                                child: ListTile(
                                  title: Text(
                                    value.allAssignment![index].name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 110, 109, 109),
                                    ),
                                  ),
                                  onTap: () async {
                                    // await Provider.of<ResultApi>(context, listen: false).getResult(
                                    //   value.allAssignment[index].courseId,
                                    //   value.allAssignment[index].id,
                                    // );
                                    Provider.of<AssignmentApi>(context, listen: false).onVisible(true);
                                    setState(() {
                                      _index = index;
                                    });

                                    // context.goNamed(
                                    //   ResultScreen.routeName,
                                    //   params: {
                                    //     'assignmentId':
                                    //         value.allAssignment![index].id.toString(),
                                    //     'lessonId': Provider.of<AssignmentApi>(context,
                                    //             listen: false)
                                    //         .lessonId
                                    //         .toString(),
                                    //   },
                                    // );
                                  },
                                ),
                              );
                            }),
                        if (Provider.of<AssignmentApi>(context).resultVisible)
                          ResultScreen(
                            lessonId: Provider.of<AssignmentApi>(
                              context,
                              listen: false,
                            ).lessonId,
                            assignmentId: value.allAssignment![_index].id,
                          )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
