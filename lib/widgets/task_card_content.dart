import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget taskCardContent(Function()? onTap, QueryDocumentSnapshot doc) {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

  return Expanded(
    child: Column(
      children: [
        Row(
          children: [
            Checkbox(
                shape: CircleBorder(),
                value: doc["done"],
                fillColor: MaterialStateProperty.resolveWith((getColor)),
                onChanged: (newValue) {
                  print('Change something');
                }),
            Text(
              doc["taskName"],
              style: const TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.w500,
                fontSize: 19.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class TaskCardContent extends StatefulWidget {
  TaskCardContent({Key? key}) : super(key: key);

  @override
  State<TaskCardContent> createState() => _TaskCardContentState();
}

class _TaskCardContentState extends State<TaskCardContent> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
