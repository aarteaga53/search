import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search/admin_list_view.dart';
import 'package:search/search_admin_list_view.dart';
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
  List filterAdmins = [];
  List filterModerators = [];
  List filterCoaches = [];
  bool isSearching = false;
  FocusNode textFocus = FocusNode();

  void updateIsSearching() {
    setState(() {
      isSearching = !isSearching;

      if(!isSearching) {
        textFocus.unfocus();
      }
    });
  }

  /// Searches for users in the list that fit the name being searched for
  void updateSearch(String searchName) {
    setState(() {
      if(searchName != '') {
        // checks that the search name length is less than the user's name to avoid errors
        // checks that the each letter in the search name is in the user's name in the same order
        filterAdmins = admins.where((element) => element['name'].length >= searchName.length && element['name'].toLowerCase().substring(0, searchName.length) == searchName.toLowerCase()).toList();
        filterModerators = moderators.where((element) => element['name'].length >= searchName.length && element['name'].toLowerCase().substring(0, searchName.length) == searchName.toLowerCase()).toList();
        filterCoaches = coaches.where((element) => element['name'].length >= searchName.length && element['name'].toLowerCase().substring(0, searchName.length) == searchName.toLowerCase()).toList();
      } else {
        filterAdmins = [];
        filterModerators = [];
        filterCoaches = [];
      }
    });
  }

  void updateAdmins(List newAdmins) {
    setState(() {
      admins = newAdmins;
    });
  }

  void updateModerators(List newModerators) {
    setState(() {
      moderators = newModerators;
    });
  }

  void updateCoaches(List newCoaches) {
    setState(() {
      coaches = newCoaches;
    });
  }

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
          isSearching ? Container() : IconButton(
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
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: updateSearch,
                      onTap: updateIsSearching,
                      focusNode: textFocus,
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
                        suffixIcon: isSearching ? IconButton(onPressed: updateIsSearching, icon: const Icon(CupertinoIcons.xmark_circle_fill)) : null,
                        suffixIconColor: Colors.grey,
                      ),
                    ),
                  ),
                  isSearching ? TextButton(onPressed: updateIsSearching, child: const Text('Cancel')) : Container()
                ],
              ),
            ),
            isSearching ? Wrap(
              children: [
                filterAdmins.isNotEmpty ? Wrap(
                  children: [
                    titleList('Admins'),
                    SearchAdminListView(filterAdmins, admins, moderators, coaches, updateAdmins, updateModerators, updateCoaches)
                  ],
                ) : Container(),
                filterModerators.isNotEmpty ? Wrap(
                  children: [
                    titleList('Moderators'),
                    SearchAdminListView(filterModerators, moderators, admins, coaches, updateAdmins, updateModerators, updateCoaches)
                  ],
                ) : Container(),
                filterCoaches.isNotEmpty ? Wrap(
                  children: [
                    titleList('Coaches'),
                    SearchAdminListView(filterCoaches, coaches, admins, moderators, updateAdmins, updateModerators, updateCoaches)
                  ],
                ) : Container(),
              ],
            ) : Wrap(
              children: [
                titleList('Admins'),
                admins.isNotEmpty ? AdminListView(admins, moderators, coaches, updateAdmins, updateModerators, updateCoaches) : emptyList('No Admins'),
                titleList('Moderators'),
                moderators.isNotEmpty ? AdminListView(moderators, admins, coaches, updateAdmins, updateModerators, updateCoaches) : emptyList('No Moderators'),
                titleList('Coaches'),
                coaches.isNotEmpty ? AdminListView(coaches, admins, moderators, updateAdmins, updateModerators, updateCoaches) : emptyList('No Coaches'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}