import 'package:flutter/material.dart';

import '../models/student.dart';

class StudentTapWidget extends StatelessWidget {
  final List<Student> data;
  const StudentTapWidget({super.key, this.data = const []});

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text('Student: ${data[index].firstName} ${data[index].lastName} is already paid!'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      title: Text(data[index].lastName),
                      subtitle: Text(data[index].firstName),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Center(
            child: Text('This group does not have students'),
          );
  }
}
