import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search/UserDetails.dart';
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
  List<UserDetails> admins = [
    UserDetails("Chuka Ikokwu", "Admin", DateTime.now()),
    UserDetails("Shaela Druyon", "Admin", DateTime.now())
  ];
  List<UserDetails> moderators = [
    UserDetails("Shushmitha Ganesh", "Moderator", DateTime.now()),
    UserDetails("Jorge Morataya", "Moderator", DateTime.now())
  ];
  List<UserDetails> coaches = [
    UserDetails("Ben Nguyen", "Coach", DateTime.now())
  ];
  // filtered lists for each admin level
  List<UserDetails> filterAdmins = [];
  List<UserDetails> filterModerators = [];
  List<UserDetails> filterCoaches = [];
  bool isSearching = false; // boolean to check if the user is searching a name
  FocusNode textFocus = FocusNode(); // search text field focus

  /// Toggles the isSearching boolean
  /// If isSearching becomes false then the text field is unfocused
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
        filterAdmins = admins.where((element) => element.name.length >= searchName.length && element.name.toLowerCase().substring(0, searchName.length) == searchName.toLowerCase()).toList();
        filterModerators = moderators.where((element) => element.name.length >= searchName.length && element.name.toLowerCase().substring(0, searchName.length) == searchName.toLowerCase()).toList();
        filterCoaches = coaches.where((element) => element.name.length >= searchName.length && element.name.toLowerCase().substring(0, searchName.length) == searchName.toLowerCase()).toList();
      } else {
        filterAdmins = [];
        filterModerators = [];
        filterCoaches = [];
      }
    });
  }

  /// Update the admin list if there is a change
  void updateAdmins(List<UserDetails> newAdmins) {
    setState(() {
      admins = newAdmins;
    });
  }

  /// Update the moderator list if there is a change
  void updateModerators(List<UserDetails> newModerators) {
    setState(() {
      moderators = newModerators;
    });
  }

  /// Update the coach list if there is a change
  void updateCoaches(List<UserDetails> newCoaches) {
    setState(() {
      coaches = newCoaches;
    });
  }

  /// Container that displays message when no users are in a specific admin level
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

  /// Container that displays the title for each level of admins and the add button
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
              // go to search page when the add button is clicked
              await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage(admins, moderators, coaches))
              );

              setState(() {

              });
            },
            icon: const Icon(CupertinoIcons.add_circled_solid, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111111),
      appBar: AppBar(
        title: const Text('Manage Admins'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.heart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: isSearching ? const EdgeInsets.only(left: 10.0, top: 3.0) : const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      onChanged: updateSearch,
                      onTap: updateIsSearching,
                      focusNode: textFocus,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.grey,
                      placeholder: 'Search',
                      placeholderStyle: const TextStyle(color: Colors.grey),
                      prefix: Container(
                        margin: const EdgeInsets.only(left: 5.0),
                        child: const Icon(CupertinoIcons.search, color: Colors.grey),
                      ),
                      suffix: isSearching ? Container(
                        margin: const EdgeInsets.only(right: 5.0),
                        child: const Icon(CupertinoIcons.xmark_circle_fill, color: Colors.grey),
                      ) : null,
                      decoration: BoxDecoration(
                        color: const Color(0xff333333),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  isSearching ? TextButton(onPressed: updateIsSearching, child: const Text('Cancel')) : Container(),
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