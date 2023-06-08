import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      "memberDate": DateTime.now(),
    },
    {
      "name": "Shaela Druyon",
      "memberDate": DateTime.now(),
    }
  ];
  List moderators = [
    {
      "name": "Shushmitha Ganesh",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Jorge Morataya",
      "memberDate": DateTime.now(),
    }
  ];
  List coaches = [
    {
      "name": "Ben Nguyen",
      "memberDate": DateTime.now(),
    },
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
            icon: const Icon(Icons.heart_broken),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                readOnly: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage())
                  );
                },
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
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: admins.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xffd3273e),
                    foregroundColor: Colors.white,
                    child: Text(admins[index]['name'].toString().substring(0, 1)),
                  ),
                  title: Text(
                    admins[index]['name'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Admin since ${DateFormat.yMd().format(admins[index]['memberDate'])}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.more_horiz, color: Colors.white,),
                );
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  const Text(
                    'Moderators',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: moderators.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xffd3273e),
                    foregroundColor: Colors.white,
                    child: Text(moderators[index]['name'].toString().substring(0, 1)),
                  ),
                  title: Text(
                    moderators[index]['name'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Admin since ${DateFormat.yMd().format(moderators[index]['memberDate'])}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.more_horiz, color: Colors.white,),
                );
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  const Text(
                    'Coaches',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: coaches.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xffd3273e),
                    foregroundColor: Colors.white,
                    child: Text(coaches[index]['name'].toString().substring(0, 1)),
                  ),
                  title: Text(
                    coaches[index]['name'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Admin since ${DateFormat.yMd().format(coaches[index]['memberDate'])}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.more_horiz, color: Colors.white,),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
