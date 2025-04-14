import 'package:flutter/material.dart';

import '../models/teacher.dart';

class TeacherWidget extends StatelessWidget {
  final List<Teacher> teachers;

  const TeacherWidget({super.key, required this.teachers});

  @override
  Widget build(BuildContext context) {
    if (teachers.isEmpty) {
      return const Center(child: Text('Professorlar mavjud emas.'));
    }

    return ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        final teacher = teachers[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ismi: ${teacher.firstName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'telegram: ${teacher.tgUsername}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  'Email: ${teacher.email}',
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
