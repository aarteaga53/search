import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List users = [
    {
      "name": "Chuka Ikokwu",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Shaela Druyon",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Shushmitha Ganesh",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Jorge Morataya",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Ben Nguyen",
      "memberDate": DateTime.now(),
    },
  ];
  List filterUsers = [];

  /// Updates the name that is being searched for
  void updateSearch(String searchName) {
    setState(() {
      if(searchName != '') {
        filterUsers = users.where((element) => element['name'].length >= searchName.length && element['name'].toLowerCase().substring(0, searchName.length) == searchName.toLowerCase()).toList();
      } else {
        filterUsers = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff222222),
      appBar: AppBar(
        title: const Text('Add an Admin'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.heart_broken),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: updateSearch,
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
                labelText: 'Search for a user...',
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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filterUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xffd3273e),
                    foregroundColor: Colors.white,
                    child: Text(filterUsers[index]['name'].toString().substring(0, 1)),
                  ),
                  title: Text(
                    filterUsers[index]['name'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Admin since ${DateFormat.yMd().format(filterUsers[index]['memberDate'])}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.more_horiz, color: Colors.white,),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
