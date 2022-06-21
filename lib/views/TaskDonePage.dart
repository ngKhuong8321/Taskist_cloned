import "package:flutter/material.dart";

class TaskDonePage extends StatefulWidget {
  TaskDonePage({Key? key}) : super(key: key);

  @override
  State<TaskDonePage> createState() => _TaskDonePageState();
}

class _TaskDonePageState extends State<TaskDonePage> {
  @override
  Widget build(BuildContext context) {
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
              SizedBox(width: 10.0, height: 10.0),
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
        child: Container(
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
                            text: 'Done',
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
              /////////////////////////
              /// CONTENT GOES HERE ///
              /////////////////////////
            ],
          ),
        ),
      ),
    );
  }
}
