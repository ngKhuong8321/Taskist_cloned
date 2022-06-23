import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:taskist_clone/color_picker.dart';
import 'package:taskist_clone/views/TaskListPage.dart';

class CreateTaskPage extends StatefulWidget {
  CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  @override
  Widget build(BuildContext context) {
    var _getInput = TextEditingController();
    Color currentColor = const Color(0xff443a49);

    /// Function for use of colorpicker - NOT FINISHED
    // void onColor(Color color) {
    //   setState(() {
    //     currentColor = color;
    //   });
    // }

    int getCurID(int len) {
      late int curID;
      String ID = '';
      for (int i = 1; i < len; i++) {
        ID += "${Random().nextInt(i)}";
      }
      curID = int.parse(ID);
      return curID;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff000000)),
        centerTitle: true,
        title: const Text(
          'New List',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(children: [
                Row(
                  children: [
                    const Text(
                      'Add the name of your list ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.add_to_photos_outlined,
                      color: currentColor,
                    ),
                  ],
                ),
                TextFormField(
                  style: const TextStyle(fontSize: 40),
                  controller: _getInput,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Your List...",
                      hintStyle: TextStyle(color: Colors.grey.shade400)),
                  cursorColor: currentColor,
                ),
              ]),
            ),
            ColorBuilder(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var name = _getInput.text;
          CollectionReference ref =
              FirebaseFirestore.instance.collection("lists");
          int curID = getCurID(9);
          ref.add({
            'listName': name,
            'id': curID,
            'progress': 0,
          });
          Navigator.of(context).pop();
        },
        label: const Text('Create Tasks List'),
        icon: const Icon(Icons.add),
        backgroundColor: currentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
