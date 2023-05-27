import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/course_api.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/grid_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> logoUrls = [
    'https://telegra.ph/file/910fb008e9b47236f5ea5.png',
    'https://telegra.ph/file/e9f7ecc57e3da64ebe4f5.png',
    'https://telegra.ph/file/36d054acce56519d7131a.png',
    'https://telegra.ph/file/5636de791b868b639ea40.png',
    'https://telegra.ph/file/d08a1c0ee647f38faed1e.png',
    'https://telegra.ph/file/8d5ba55ac41ba20d98a06.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: FutureBuilder(
        future: Provider.of<CourseApi>(context, listen: false).getCourse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitThreeInOut(
                color: Colors.black,
                size: 30,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "CODEACADEMY",
                          style: GoogleFonts.allertaStencil(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      itemCount: Provider.of<CourseApi>(context, listen: false).courses.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) => GridItemWidget(
                        logoLink: logoUrls[index],
                        item: Provider.of<CourseApi>(context, listen: false).courses[index],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
