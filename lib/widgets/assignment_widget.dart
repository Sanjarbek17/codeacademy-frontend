import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/assignment_api.dart';
import '../screens/result_screen.dart';

class AssignmentWidget extends StatefulWidget {
  const AssignmentWidget({super.key});

  @override
  State<AssignmentWidget> createState() => _AssignmentWidgetState();
}

class _AssignmentWidgetState extends State<AssignmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 4,
        child: Consumer<AssignmentApi>(
            builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: const Text(
                                'Scientific Work 1',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                'Description of Scientific Work 1',
                                style: TextStyle(fontSize: 16),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(lessonId: 1, assignmentId: 1),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: const Text(
                                'Scientific Work 2',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                'Description of Scientific Work 2',
                                style: TextStyle(fontSize: 16),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(lessonId: 1, assignmentId: 2),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
