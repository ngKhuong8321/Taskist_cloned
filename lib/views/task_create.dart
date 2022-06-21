import "package:flutter/material.dart";
import 'package:localstorage/localstorage.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CreateTaskPage extends StatefulWidget {
  CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  @override
  Widget build(BuildContext context) {
    var _getInput = TextEditingController();
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
          children: [
            Row(
              children: const [
                Text(
                  'Add the name of your list ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                Icon(
                  Icons.add_to_photos_outlined,
                  color: Color(0xff6933FF),
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
              cursorColor: const Color(0xff6933ff),
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff6933ff),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var name = _getInput.text;
          debugPrint('Name: ${name}');
        },
        label: const Text('Create Tasks List'),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xff6933ff),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
