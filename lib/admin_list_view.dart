import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//ignore: must_be_immutable
class AdminListView extends StatefulWidget {
  List mainList;
  List secondList;
  List thirdList;

  AdminListView(this.mainList, this.secondList, this.thirdList, {Key? key}) : super(key: key);

  @override
  State<AdminListView> createState() => _AdminListViewState();
}

class _AdminListViewState extends State<AdminListView> {

  /// Assign a user to admin level
  CupertinoActionSheetAction assignAdminAction() {
    return CupertinoActionSheetAction(
      child: const Text('Assign as Admin'),
      onPressed: () {


        Navigator.pop(context);
      },
    );
  }

  /// Assign a user to moderator level
  CupertinoActionSheetAction assignModeratorAction() {
    return CupertinoActionSheetAction(
      child: const Text('Assign as Moderator'),
      onPressed: () {


        Navigator.pop(context);
      },
    );
  }

  /// Assign a user to coach level
  CupertinoActionSheetAction assignCoachAction() {
    return CupertinoActionSheetAction(
      child: const Text('Assign as Coach'),
      onPressed: () {


        Navigator.pop(context);
      },
    );
  }

  /// Remove a user from their admin level
  CupertinoActionSheetAction removeAdminAction(int index) {
    return CupertinoActionSheetAction(
      isDestructiveAction: true,
      child: const Text('Remove'),
      onPressed: () {
        setState(() {
          widget.mainList.removeAt(index);
        });

        Navigator.pop(context);
      },
    );
  }

  /// Create a list of available actions depending on the current user's admin level
  List<CupertinoActionSheetAction> showModalActions(int index) {
    switch(widget.mainList[index]['level']) {
      case 'Admin':
        return <CupertinoActionSheetAction>[assignModeratorAction(), assignCoachAction(), removeAdminAction(index)];
      case 'Moderator':
        return <CupertinoActionSheetAction>[assignAdminAction(), assignCoachAction(), removeAdminAction(index)];
      case 'Coach':
        return <CupertinoActionSheetAction>[assignAdminAction(), assignModeratorAction(), removeAdminAction(index)];
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
            child: Text(widget.mainList[index]['name'].toString().substring(0, 1)),
          ),
          title: Text(
            widget.mainList[index]['name'],
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Admin since ${DateFormat.yMd().format(widget.mainList[index]['memberDate'])}',
            style: const TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoActionSheet(
                    title: Text('${widget.mainList[index]['level']} - ${widget.mainList[index]['name'].substring(0, widget.mainList[index]['name'].indexOf(' '))}'),
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
    );;
  }
}
