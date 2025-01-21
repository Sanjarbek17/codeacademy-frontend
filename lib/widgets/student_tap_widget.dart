import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

import '../models/student.dart';
import '../providers/student_api.dart';

class StudentTapWidget extends StatefulWidget {
  final List<Student> data;
  const StudentTapWidget({super.key, this.data = const []});

  @override
  State<StudentTapWidget> createState() => _StudentTapWidgetState();
}

class _StudentTapWidgetState extends State<StudentTapWidget> {
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
                        (student) => ExpansionPanelRadio(
                          canTapOnHeader: true,
                          value: student,
                          headerBuilder: (context, isExpanded) => ListTile(
                            title: Text(student.lastName),
                            subtitle: Text(student.firstName),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                Provider.of<StudentApi>(context, listen: false).deleteStudent(studentId: student.id).then((value) {
                                  setState(() {
                                    if (value['status'] == 'student deleted') {
                                      setState(() {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student deleted')));
                                      });
                                    } else {
                                      setState(() {
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
                                'Student: ${student.firstName} ${student.lastName}\'s payment date!',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text('Start date: ${formatDate(DateTime.parse(student.startDate!), [dd, '.', mm, '.', yyyy, ' ', HH, ':', nn])}'),
                                  const SizedBox(height: 10),
                                  Text('End date: ${formatDate(DateTime.parse(student.endDate!), [dd, '.', mm, '.', yyyy, ' ', HH, ':', nn])}'),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text('${student.firstName} ${student.lastName}'),
                                                content: SizedBox(
                                                  width: 300,
                                                  height: 350,
                                                  child: CalendarDatePicker2(
                                                    config: CalendarDatePicker2Config(
                                                      calendarType: CalendarDatePicker2Type.range,
                                                      currentDate: DateTime.now(),
                                                      calendarViewMode: CalendarDatePicker2Mode.day,
                                                    ),
                                                    value: [DateTime(2023)],
                                                    onValueChanged: (dates) {
                                                      student.startDate = dates[0].toString();
                                                      student.endDate = dates[1].toString();
                                                    },
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: const Text('Cencel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Submit'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     TextButton(
                              //       onPressed: () => Navigator.pop(context),
                              //       child: const Text('Cencel'),
                              //     ),
                              //     TextButton(
                              //       onPressed: () => Navigator.pop(context),
                              //       child: const Text('Done'),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
                // ListView.builder(
                //   itemCount: widget.data.length,
                //   itemBuilder: (context, index) => Card(
                //     child: ListTile(
                //       onTap: () {
                //         showDialog(
                //           context: context,
                //           builder: (context) => AlertDialog(
                //             title: Text('Student: ${widget.data[index].firstName} ${widget.data[index].lastName}\'s payment date!'),
                //             content: Column(
                //               children: [
                //                 Text('Start date: ${widget.data[index].startDate}'),
                //                 const SizedBox(height: 10),
                //                 Text('End date: ${widget.data[index].endDate}'),
                //                 Row(
                //                   children: [
                //                     const Spacer(),
                //                     IconButton(
                //                       onPressed: () {},
                //                       icon: const Icon(Icons.edit),
                //                     ),
                //                   ],
                //                 )
                //               ],
                //             ),
                //             actions: [
                //               TextButton(
                //                 onPressed: () => Navigator.pop(context),
                //                 child: const Text('Close'),
                //               ),
                //             ],
                //           ),
                //         );
                //       },
                //       title: Text(widget.data[index].lastName),
                //       subtitle: Text(widget.data[index].firstName),
                //       trailing: IconButton(
                //         icon: const Icon(Icons.delete_outline),
                //         onPressed: () {
                //           Provider.of<StudentApi>(context, listen: false).deleteStudent(studentId: widget.data[index].id).then((value) {
                //             setState(() {
                //               if (value['status'] == 'student deleted') {
                //                 setState(() {
                //                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student deleted')));
                //                   print('student deleted');
                //                 });
                //               } else {
                //                 setState(() {
                //                   print(value['status']);
                //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value['status'].toString())));
                //                 });
                //               }
                //             });
                //           });
                //         },
                //       ),
                //     ),
                //   ),
                // ),
              ),
            ),
          )
        : const Center(
            child: Text('This group does not have students'),
          );
  }
}
