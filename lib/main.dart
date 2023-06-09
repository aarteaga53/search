import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search/admin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int selectedIndex = 0; // index for navigation bar item
  String searchName = ""; // the name that is being searched for
  List pageList = [
    const AdminPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff222222),
      body: pageList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2),
            label: 'Admin',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.block_flipped),
            label: 'Ban',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bubble_left_fill),
            label: 'Chat',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.check_mark_circled),
            label: 'Pending',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
