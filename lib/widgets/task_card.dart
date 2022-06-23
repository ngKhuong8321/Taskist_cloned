import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'task_card_content.dart';

Widget taskCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 300,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xff6933ff),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0.0, 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                doc["listName"],
                style: const TextStyle(
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w500,
                  fontSize: 19.0,
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 3,
            color: Colors.white,
            indent: 60,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("tasks")
                    .where("listID", isEqualTo: doc["id"])
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
                      children: snapshot.data!.docs
                          .map((tasks) => taskCardContent(() {}, tasks))
                          .toList(),
                    );
                  }
                  return const Text("There's no notes");
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
