import 'package:flutter/material.dart';
import 'package:taskist_clone/views/TaskDonePage.dart';
import 'package:taskist_clone/views/TaskListPage.dart';
import 'package:taskist_clone/views/TaskSettingsPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        appBarTheme: const AppBarTheme(
          color: Color(0xFFefefef),
        ),
      ),
      home: const MyHomePage(title: 'ToDO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 1;
  List<Widget> pages = [
    const TaskDonePage(),
    TaskListPage(),
    const TaskSettingPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],

      ////////////////////////////////////////////////////////////////////
      ///                      BOTTOM NAV BAR HERE                     ///
      ////////////////////////////////////////////////////////////////////

      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.snippet_folder), label: ''),
          NavigationDestination(icon: Icon(Icons.list), label: ''),
          NavigationDestination(icon: Icon(Icons.settings), label: ''),
        ],
        onDestinationSelected: (int index) {
          setState(
            () {
              currentPage = index;
            },
          );
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
