import "package:flutter/material.dart";

int itemCount = 4;

String version = '1.0.0 Cloned';

Map<int, String> sectionTitle = {
  0: 'Version',
  1: 'Twitter',
  2: 'Rate Taskist',
  3: 'Share Taskist',
};
Map<int, Icon> sectionNum = const {
  0: Icon(
    Icons.room_preferences,
    color: Colors.grey,
  ),
  1: Icon(
    Icons.person_add,
    color: Colors.blue,
  ),
  2: Icon(
    Icons.star,
    color: Colors.blue,
  ),
  3: Icon(
    Icons.share,
    color: Colors.blue,
  ),
};
Map<int, Icon> trailingIcon = const {
  0: Icon(
    Icons.arrow_forward_ios,
    color: Colors.grey,
  ),
  1: Icon(
    Icons.arrow_forward_ios,
    color: Colors.grey,
  ),
  2: Icon(
    Icons.arrow_forward_ios,
    color: Colors.grey,
  ),
  3: Icon(
    Icons.arrow_forward_ios,
    color: Colors.grey,
  ),
};

class TaskSettingPage extends StatefulWidget {
  TaskSettingPage({Key? key}) : super(key: key);

  @override
  State<TaskSettingPage> createState() => _TaskSettingPageState();
}

class _TaskSettingPageState extends State<TaskSettingPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.history_edu_outlined,
              color: Color(0xff6933FF),
              size: 60.0,
            )
          ],
        ),
      ),

      ////////////////////////////////////////////////////////////////////
      ///                        BODY STARTED HERE                     ///
      ////////////////////////////////////////////////////////////////////

      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
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
                            text: 'Settings',
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

              Center(
                child: Container(
                  width: 0.98 * size.width,
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0.0, 0.05),
                    )
                  ]),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: Color(0xffffffff),
                        title: Text(sectionTitle[index] ??= ''),
                        leading: sectionNum[index],
                        trailing: trailingIcon[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
