// ignore_for_file: must_be_immutable

import 'package:codeacademy/models/message.dart';
import 'package:codeacademy/widgets/grid_item_news.dart';
import 'package:flutter/material.dart';

class NewsMessage extends StatelessWidget {
  List<Message> data;
  NewsMessage({super.key, this.data = const []});

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Center(
            child: GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => GridItemNews(
                      title: data[index].title,
                      body: data[index].body,
                      date: data[index].date,
                      isNew: data[index].isNew,
                    )),
          )
        : const Center(
            child: Text('There is no news!'),
          );
  }
}
