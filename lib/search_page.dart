import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  List admins;
  List moderators;
  List coaches;

  SearchPage(this.admins, this.moderators, this.coaches, {Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  // dummy data for a list of users
  List users = [
    {
      "name": "Joanne Robinson",
      "level": "none",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Joe Mike",
      "level": "none",
      "memberDate": DateTime.now(),
    },
    {
      "name": "John Jameson",
      "level": "none",
      "memberDate": DateTime.now(),
    },
    {
      "name": "John Johnson",
      "level": "none",
      "memberDate": DateTime.now(),
    },
    {
      "name": "Joseph Smith",
      "level": "none",
      "memberDate": DateTime.now(),
    },
  ];
  List filterUsers = [];
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
        filterUsers = users.where((element) => element['name'].length >= searchName.length && element['name'].toLowerCase().substring(0, searchName.length) == searchName.toLowerCase()).toList();
      } else {
        filterUsers = [];
      }
    });
  }

  /// Modal popup that asks to confirm you are assigning a user admin level
  void showModalAssignAdmin(String level, int index) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Assign as $level?'),
            content: Text('Are you sure you want to give this user $level privileges?'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    filterUsers[index]['level'] = level; // changing the user's admin level

                    // adds the user to the correct list for admin level
                    switch(level) {
                      case 'Admin':
                        widget.admins.add(filterUsers[index]);
                        break;
                      case 'Moderator':
                        widget.moderators.add(filterUsers[index]);
                        break;
                      case 'Coach':
                        widget.coaches.add(filterUsers[index]);
                        break;
                    }

                    // removing the user from the search lists
                    users.remove(filterUsers[index]);
                    filterUsers.removeAt(index);
                  });

                  Navigator.pop(context);

                  showModalAdmin(level);
                },
                child: Text('Assign as $level'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        }
    );
  }

  /// Modal popup that let's you know that the user has been assigned an admin level
  void showModalAdmin(String level) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('$level Added'),
            content: level == 'Admin' ? Text('The user is now an $level') : Text('The user is now a $level.'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        }
    );
  }

  /// Modal popup that shows available actions on a searched user
  void showModalActions(int index) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(filterUsers[index]['name']),
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Assign as Admin'),
              onPressed: () {
                Navigator.pop(context);

                showModalAssignAdmin('Admin', index);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Assign as Moderator'),
              onPressed: () {
                Navigator.pop(context);

                showModalAssignAdmin('Moderator', index);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Assign as Coach'),
              onPressed: () {
                Navigator.pop(context);

                showModalAssignAdmin('Coach', index);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
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
            icon: const Icon(CupertinoIcons.heart_fill),
          ),
        ],
      ),
      body: Column(
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
                      labelText: 'Search for a user...',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      fillColor: const Color(0xff333333),
                      prefixIcon: const Icon(CupertinoIcons.search),
                      prefixIconColor: Colors.grey,
                      suffixIcon: isSearching ? IconButton(onPressed: updateIsSearching, icon: const Icon(CupertinoIcons.xmark_circle_fill)) : null,
                      suffixIconColor: Colors.grey,
                    ),
                  ),
                ),
                isSearching ? TextButton(
                  onPressed: updateIsSearching,
                  child: const Text('Cancel'),
                ) : Container()
              ],
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
                    'Member since ${DateFormat.yMd().format(filterUsers[index]['memberDate'])}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showModalActions(index);
                    },
                    icon: const Icon(Icons.more_horiz, color: Colors.white, size: 36),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
