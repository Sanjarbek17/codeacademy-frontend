import 'package:codeacademy/constants/constants.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import '../models/lesson.dart';

class AssignmentWidget extends StatelessWidget {
  final List<Lesson> lessons;

  const AssignmentWidget({super.key, required this.lessons});

  Future<void> _downloadFile(String url) async {
    try {
      final fullUrl = '$baseUrl$url';
      // Trigger the browser to download the file
      html.AnchorElement anchor = html.AnchorElement(href: fullUrl)
        ..target = 'blank'
        ..download = fullUrl.split('/').last;
      anchor.click();
    } catch (e) {
      debugPrint('Error downloading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return const Center(
        child: Text('Ilmiy ishlar mavjud emas.'), // Translated to Uzbek
      );
    }

    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return InkWell(
          onTap: () {
            if (lesson.fileUrl != null) {
              _downloadFile(lesson.fileUrl!);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Yuklab olish uchun fayl mavjud emas.')), // Translated to Uzbek
              );
            }
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ilmiy Ish: ${lesson.name}', // Changed "Lesson" to "Ilmiy Ish"
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (lesson.description != null)
                    Text(
                      'Tavsif: ${lesson.description}', // Translated "Description" to "Tavsif"
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
