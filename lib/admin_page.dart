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

  List admins = [
    {
      "name": "Chuka Ikokwu",
      "level": "admin",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Shaela Druyon",
      "level": "admin",
      "memberDate": DateTime.now(),
    }
  ];
  List moderators = [
    {
      "name": "Shushmitha Ganesh",
      "level": "moderator",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Jorge Morataya",
      "level": "moderator",
      "memberDate": DateTime.now(),
    }
  ];
  List coaches = [
    {
      "name": "Ben Nguyen",
      "level": "coach",
      "memberDate": DateTime.now(),
    }
  ];

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
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  const Text(
                    'Admins',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
            ),
            admins.isNotEmpty ? AdminsListView(list: admins) : Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15.0),
              child: const Text(
                'No Admins',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  const Text(
                    'Moderators',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
            ),
            moderators.isNotEmpty ? AdminsListView(list: moderators) : Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15.0),
              child: const Text(
                'No Moderators',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  const Text(
                    'Coaches',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
            ),
            coaches.isNotEmpty ? AdminsListView(list: coaches) : Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15.0),
              child: const Text(
                'No Coaches',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
