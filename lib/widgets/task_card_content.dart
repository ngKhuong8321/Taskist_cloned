import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
                shape: const CircleBorder(),
                value: doc["done"],
                fillColor: MaterialStateProperty.resolveWith((getColor)),
                activeColor: const Color(0xff6933ff),
                checkColor: const Color(0xff6933ff),
                onChanged: (newValue) {}),
            const SizedBox(
              width: 5.0,
              height: 5.0,
            ),
            if (doc["done"] == false) ...[
              Text(
                doc["taskName"],
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w500,
                  fontSize: 19.0,
                ),
              ),
            ] else ...[
              Text(
                doc["taskName"],
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                    fontSize: 19.0,
                    decoration: TextDecoration.lineThrough),
              ),
            ],
          ],
        ),
      ],
    ),
  );
}

/// TASK PAGE CONTENT ///

Widget taskContent(Function()? onTap, QueryDocumentSnapshot doc,
    CollectionReference collection, CollectionReference listCollection) {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    const Set<MaterialState> SelectedStates = <MaterialState>{
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return const Color(0xffefefef);
    } else if (states.any(SelectedStates.contains)) {
      return const Color(0xff6933ff);
    } else {
      return Colors.grey.shade500;
    }
  }

  return Column(
    children: [
      Row(
        children: [
          if (doc['done'] == false) ...[
            Slidable(
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (context) {
                    FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(doc.id)
                        .delete();
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                ),
              ]),
              child: SizedBox(
                width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                        .size
                        .width *
                    0.7,
                child: Row(children: [
                  Checkbox(
                      value: doc["done"],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      fillColor: MaterialStateProperty.resolveWith((getColor)),
                      onChanged: (newValue) async {
                        Map<String, dynamic> newData = {
                          "done": newValue,
                        };
                        collection.doc(doc.id).update(newData);
                      }),
                  const SizedBox(width: 30.0, height: 30.0),
                  Text(
                    doc["taskName"],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                      fontSize: 29.0,
                    ),
                  ),
                ]),
              ),
            ),
          ] else ...[
            Checkbox(
                value: doc["done"],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0)),
                fillColor: MaterialStateProperty.resolveWith(getColor),
                onChanged: (newValue) async {
                  Map<String, dynamic> newData = {
                    "done": newValue,
                  };
                  collection.doc(doc.id).update(newData);
                }),
            const SizedBox(width: 30.0, height: 30.0),
            Text(
              doc["taskName"],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              style: const TextStyle(
                color: Color(0xff6933ff),
                fontWeight: FontWeight.w500,
                fontSize: 29.0,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ]
        ],
      ),
    ],
  );
}
