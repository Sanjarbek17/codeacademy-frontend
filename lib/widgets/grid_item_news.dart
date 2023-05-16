// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GridItemNews extends StatelessWidget {
  String title;
  String body;
  String date;
  String? image;
  bool isNew;
  GridItemNews({
    super.key,
    required this.title,
    required this.body,
    required this.date,
    this.image,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isNew ? Colors.amber[200]! : Colors.transparent,
            width: isNew ? 3 : 0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.maxFinite,
              padding: const EdgeInsets.all(10),
              child: Image.network(
                image ?? 'https://epss.ucla.edu/static/images/default-news.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 10,
              ),
              child: Text(
                title,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                body,
                maxLines: 7,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                date.substring(0, 16),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
