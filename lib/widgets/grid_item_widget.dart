// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/assignment_api.dart';
import '../providers/group_api.dart';
import '../screens/categories_screen.dart';

class GridItemWidget extends StatelessWidget {
  final Course item;
  final String logoLink;
  const GridItemWidget({super.key, required this.item, required this.logoLink});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: SpinKitThreeInOut(
              color: Colors.black,
              size: 30,
            ),
          ),
        );
        // await Provider.of<GroupApi>(context, listen: false).getGroup(item.id);
        Navigator.pop(context);
        // Provider.of<AssignmentApi>(context, listen: false).onVisible(false);
        // Provider.of<AssignmentApi>(context, listen: false).nullAssignment();
        context.goNamed(CategoriesScreen.routeName);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
          // image: DecorationImage(
          //   image: NetworkImage(logoLink),
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 8,
              height: MediaQuery.of(context).size.width / 8,
              child: Image.asset(
                logoLink,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
