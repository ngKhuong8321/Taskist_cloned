///import 'dart:ffi';

import "package:flutter/material.dart";
import 'package:taskist_clone/views/TaskDonePage.dart';
import 'package:taskist_clone/views/TaskSettingsPage.dart';
import 'package:taskist_clone/views/task_add.dart';
import 'package:taskist_clone/views/task_create.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskist_clone/widgets/task_card.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  bool isLoading = false;

  @override
  void _initState() {
    debugPrint('initState runnning...');

    refreshNotes();
    super.initState();
  }

  @override
  void dispose() {
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    debugPrint('refreshNotes');

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    refreshNotes();
    int currentPage = 0;
    List<Widget> pages = [
      const TaskDonePage(),
      TaskListPage(),
      const TaskSettingPage()
    ];

    DateTime now = DateTime.now();
    Map<int, String> thisMonth = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sep",
      10: "Oct",
      11: "Nov",
      12: "Dec",
    };
    Map<int, String> thisWeekDay = {
      1: "Monday",
      2: "Tuesday",
      3: "Wednesday",
      4: "Thursday",
      5: "Friday",
      6: "Sartuday",
      7: "Sunday",
    };
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10.0, height: 10.0),
              Text(
                thisWeekDay[now.weekday] ??= "Can't detect weekday ",
                style: const TextStyle(
                  color: Color(0xff000000),
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                children: [
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: now.day.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                          text: thisMonth[now.month],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      ////////////////////////////////////////////////////////////////////
      ///                        BODY STARTED HERE                     ///
      ////////////////////////////////////////////////////////////////////

      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    height: 20,
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Task',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: 'Lists',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    height: 20,
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 60.0,
              height: 60.0,
              child: OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateTaskPage()),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Add List',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w100,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 40.0,
              height: 40.0,
            ),
            SizedBox(
              height: 500,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("lists")
                    .where('progress', isLessThan: 1)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.docs
                          .map((lists) => taskCard(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        AddTaskPage(curList: lists)),
                                  ),
                                );
                              }, lists))
                          .toList(),
                    );
                  }
                  return const Text("There's no notes");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
