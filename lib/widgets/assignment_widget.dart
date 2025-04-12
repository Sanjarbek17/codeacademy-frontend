import 'package:flutter/material.dart';

import '../models/lesson.dart';

class AssignmentWidget extends StatelessWidget {
  final List<Lesson> lessons;

  const AssignmentWidget({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return const Center(
        child: Text('No lessons available.'),
      );
    }

    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lesson: ${lesson.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                if (lesson.description != null)
                  Text(
                    'Description: ${lesson.description}',
                    style: const TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
