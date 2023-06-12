import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search/UserDetails.dart';

//ignore: must_be_immutable
class AdminListView extends StatefulWidget {
  List<UserDetails> mainList; // admin, moderator, coach
  List<UserDetails> secondList; // moderator, admin, admin
  List<UserDetails> thirdList; // coach, coach, moderator
  void Function(List<UserDetails> newAdmins) updateAdmins;
  void Function(List<UserDetails> newModerators) updateModerators;
  void Function(List<UserDetails> newCoaches) updateCoaches;

  AdminListView(this.mainList, this.secondList, this.thirdList, this.updateAdmins, this.updateModerators, this.updateCoaches, {Key? key}) : super(key: key);

  @override
  State<AdminListView> createState() => _AdminListViewState();
}

class _AdminListViewState extends State<AdminListView> {

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
                    String curLevel = widget.mainList[index].level; // current admin level
                    widget.mainList[index].level = level; // changing the user's admin level

                    // adds user to new admin level list and updates the list
                    switch(level) {
                      case 'Admin':
                        // add user to new admin list and update the list
                        widget.secondList.add(widget.mainList[index]);
                        widget.updateAdmins(widget.secondList);
                        break;
                      case 'Moderator':
                        // changing to moderator could be two different lists
                        switch(curLevel) {
                          case 'Admin':
                            // add user to new admin list and update the list
                            widget.secondList.add(widget.mainList[index]);
                            widget.updateModerators(widget.secondList);
                            break;
                          case 'Coach':
                            // add user to new admin list and update the list
                            widget.thirdList.add(widget.mainList[index]);
                            widget.updateModerators(widget.thirdList);
                            break;
                          default:
                            break;
                        }
                        break;
                      case 'Coach':
                        // add user to new admin list and update the list
                        widget.thirdList.add(widget.mainList[index]);
                        widget.updateCoaches(widget.thirdList);
                        break;
                    }

                    // removing the user from their old admin level list
                    widget.mainList.removeAt(index);
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

  /// Modal popup that asks to confirm you are removing admin level
  void showModalRemoveAdmin(String level, int index) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Remove from ${level}s?'),
            content: Text('Are you sure you want to remove this user\'s $level privileges?'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    // removing the user from their admin level
                    widget.mainList.removeAt(index);
                  });

                  Navigator.pop(context);

                  showModalAdminRemoved(level);
                },
                child: Text('Remove $level'),
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

  /// Modal popup that let's you know that the user is no longer an admin
  void showModalAdminRemoved(String level) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('$level Removed'),
            content: level == 'Admin' ? Text('The user is no longer an $level') : Text('The user is no longer a $level.'),
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

  /// Assign a user to specified admin level
  CupertinoActionSheetAction assignAdminAction(String level, int index) {
    return CupertinoActionSheetAction(
      child: Text('Assign as $level'),
      onPressed: () {
        Navigator.pop(context);

        showModalAssignAdmin(level, index);
      },
    );
  }

  /// Remove a user from their admin level
  CupertinoActionSheetAction removeAdminAction(int index) {
    return CupertinoActionSheetAction(
      isDestructiveAction: true,
      child: const Text('Remove'),
      onPressed: () {
        Navigator.pop(context);

        showModalRemoveAdmin(widget.mainList[index].level, index);
      },
    );
  }

  /// Create a list of available actions depending on the current user's admin level
  List<CupertinoActionSheetAction> showModalActions(int index) {
    switch(widget.mainList[index].level) {
      case 'Admin':
        return <CupertinoActionSheetAction>[assignAdminAction('Moderator', index), assignAdminAction('Coach', index), removeAdminAction(index)];
      case 'Moderator':
        return <CupertinoActionSheetAction>[assignAdminAction('Admin', index), assignAdminAction('Coach', index), removeAdminAction(index)];
      case 'Coach':
        return <CupertinoActionSheetAction>[assignAdminAction('Admin', index), assignAdminAction('Moderator', index), removeAdminAction(index)];
      default:
        return <CupertinoActionSheetAction>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.mainList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xffd3273e),
            foregroundColor: Colors.white,
            child: Text(widget.mainList[index].name.toString().substring(0, 1)),
          ),
          title: Text(
            widget.mainList[index].name,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Admin since ${DateFormat.yMd().format(widget.mainList[index].memberDate)}',
            style: const TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoActionSheet(
                    title: Text('${widget.mainList[index].level} - ${widget.mainList[index].name.substring(0, widget.mainList[index].name.indexOf(' '))}'),
                    actions: showModalActions(index),
                    cancelButton: CupertinoActionSheetAction(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.more_horiz, color: Colors.white, size: 36,),
          ),
        );
      },
    );
  }
}
