import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:taskist_clone/color_picker.dart';
import 'package:taskist_clone/views/TaskListPage.dart';

import '../widgets/task_card_content.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({Key? key, required this.curList}) : super(key: key);

  QueryDocumentSnapshot curList;
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  // initState() async {
  //   all = await allTask(widget.curList);
  //   fin = await finishedTask(widget.curList);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var _getInput = TextEditingController();

    deleteTask(QueryDocumentSnapshot<Object?> doc) {
      FirebaseFirestore.instance.collection('tasks').doc(doc.id);
    }

    Future<void> _showAddDialog(
        CollectionReference ref, int id, QueryDocumentSnapshot list) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    controller: _getInput,
                    decoration: const InputDecoration(
                        labelText: 'New Item', hintText: 'New Item'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () {
                  ref.add({
                    'taskName': _getInput.text,
                    'listID': list['id'],
                    'taskID': id,
                    'done': false,
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _delete(List<QueryDocumentSnapshot> respectiveTasks) async {
      for (var i = 0; i < respectiveTasks.length; i++) {
        print(respectiveTasks[i]['taskName']);
      }
    }

    Future<void> _showDeleteDialog(QueryDocumentSnapshot curList) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete: ${curList['listName']}"),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Are you sure you want to delete this list!'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Yes'),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('tasks')
                      .doc(curList.id)
                      .delete();
                  FirebaseFirestore.instance
                      .collection('lists')
                      .doc(curList.id)
                      .delete();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => TaskListPage()),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    int getCurID(int len) {
      late int curID;
      String ID = '';
      for (int i = 1; i < len; i++) {
        ID += "${Random().nextInt(i)}";
      }
      curID = int.parse(ID);
      return curID;
    }

    double currentProgress = widget.curList['progress'];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff000000)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("tasks")
                  .where("listID", isEqualTo: widget.curList["id"])
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot1.hasData) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("tasks")
                        .where("listID", isEqualTo: widget.curList["id"])
                        .where('done', isEqualTo: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                      if (snapshot1.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot1.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    primary: const Color(0xffefefef),
                                    elevation: 0,
                                    fixedSize: const Size(56.0, 56.0)),
                                onPressed: (() => {
                                      if (snapshot1.data!.docs.isEmpty)
                                        {
                                          currentProgress = 0,
                                        }
                                      else
                                        {
                                          currentProgress =
                                              snapshot2.data!.docs.length /
                                                  snapshot1.data!.docs.length,
                                        },
                                      FirebaseFirestore.instance
                                          .collection('lists')
                                          .doc(widget.curList.id)
                                          .update(
                                              {'progress': currentProgress}),
                                      Navigator.pop(context)
                                    }),
                                child: const Icon(
                                  Icons.close,
                                  color: Color(0xff6933ff),
                                  size: 40.0,
                                ),
                              ),
                              const SizedBox(width: 20.0, height: 20.0),
                            ],
                          ),
                        );
                      }
                      return const Text("Can't get finished");
                    },
                  );
                }
                return const Text("Can't get all");
              },
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    widget.curList['listName'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      primary: const Color(0xffefefef),
                      elevation: 0,
                      fixedSize: const Size(56.0, 56.0)),
                  onPressed: (() => {_showDeleteDialog(widget.curList)}),
                  child: const Icon(
                    Icons.delete,
                    color: Color(0xff6933ff),
                    size: 40.0,
                  ),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("tasks")
                  .where("listID", isEqualTo: widget.curList["id"])
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot1.hasData && snapshot1.data!.docs.isNotEmpty) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("tasks")
                        .where("listID", isEqualTo: widget.curList["id"])
                        .where('done', isEqualTo: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                      if (snapshot1.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot2.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  '${snapshot2.data!.docs.length} of ${snapshot1.data!.docs.length}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQueryData.fromWindow(
                                                WidgetsBinding.instance.window)
                                            .size
                                            .width -
                                        128,
                                    child: LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Color(0xff6933ff)),
                                      backgroundColor: Colors.grey.shade300,
                                      minHeight: 3,
                                      value: snapshot2.data!.docs.length /
                                          snapshot1.data!.docs.length,
                                    ),
                                  ),
                                  Text(
                                    '${((snapshot2.data!.docs.length / snapshot1.data!.docs.length) * 100).round()} %',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return const Text("Can't get finished");
                    },
                  );
                } else if (snapshot1.hasData && snapshot1.data!.docs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('0 of 0'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQueryData.fromWindow(
                                          WidgetsBinding.instance.window)
                                      .size
                                      .width -
                                  128,
                              child: LinearProgressIndicator(
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Color(0xff6933ff)),
                                  backgroundColor: Colors.grey.shade300,
                                  minHeight: 3,
                                  value: 0),
                            ),
                            const Text(
                              '0 %',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return const Text("Can't get all");
              },
            ),
            Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("tasks")
                      .where("listID", isEqualTo: widget.curList["id"])
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: ListView(
                                physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                children: snapshot.data!.docs
                                    .map((tasks) => taskContent(
                                        () {},
                                        tasks,
                                        FirebaseFirestore.instance
                                            .collection('tasks'),
                                        FirebaseFirestore.instance
                                            .collection('lists')))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Text("There's no notes");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CollectionReference ref =
              FirebaseFirestore.instance.collection("tasks");
          int curID = getCurID(9);
          _showAddDialog(ref, curID, widget.curList);
        },
        backgroundColor: const Color(0xff6933ff),
        child: const Icon(Icons.add),
      ),
    );
  }
}
