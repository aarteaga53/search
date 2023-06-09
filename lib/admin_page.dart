import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search/admins_list_view.dart';
import 'package:search/search_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  // dummy data for admin users
  List admins = [
    {
      "name": "Chuka Ikokwu",
      "level": "Admin",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Shaela Druyon",
      "level": "Admin",
      "memberDate": DateTime.now(),
    }
  ];
  List moderators = [
    {
      "name": "Shushmitha Ganesh",
      "level": "Moderator",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Jorge Morataya",
      "level": "Moderator",
      "memberDate": DateTime.now(),
    }
  ];
  List coaches = [
    {
      "name": "Ben Nguyen",
      "level": "Coach",
      "memberDate": DateTime.now(),
    }
  ];

  /// container that displays message when no users are in a certain admin level
  Container emptyList(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  /// container that displays the title for each level of admins
  Container titleList(String level) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: [
          Text(
            level,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage(admins, moderators, coaches))
              );

              setState(() {

              });
            },
            icon: const Icon(Icons.add_circle, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff222222),
      appBar: AppBar(
        title: const Text('Manage Admins'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.heart_fill),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xff333333),
                      width: 0.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xff333333),
                      width: 0.0,
                    ),
                  ),
                  labelText: 'Search',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: const Color(0xff333333),
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.grey,
                ),
              ),
            ),
            titleList('Admins'),
            admins.isNotEmpty ? AdminsListView(list: admins) : emptyList('No Admins'),
            titleList('Moderators'),
            moderators.isNotEmpty ? AdminsListView(list: moderators) : emptyList('No Moderators'),
            titleList('Coaches'),
            coaches.isNotEmpty ? AdminsListView(list: coaches) : emptyList('No Coaches'),
          ],
        ),
      ),
    );
  }
}