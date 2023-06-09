import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//ignore: must_be_immutable
class AdminsListView extends StatelessWidget {
  List list;

  AdminsListView({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xffd3273e),
            foregroundColor: Colors.white,
            child: Text(list[index]['name'].toString().substring(0, 1)),
          ),
          title: Text(
            list[index]['name'],
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Admin since ${DateFormat.yMd().format(list[index]['memberDate'])}',
            style: const TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoActionSheet(
                    title: Text('${list[index]['level']} - ${list[index]['name'].substring(0, list[index]['name'].indexOf(' '))}'),
                    actions: <CupertinoActionSheetAction>[
                      CupertinoActionSheetAction(
                        child: const Text('Assign as Admin'),
                        onPressed: () {


                          Navigator.pop(context);
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: const Text('Assign as Moderator'),
                        onPressed: () {


                          Navigator.pop(context);
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: const Text('Assign as Coach'),
                        onPressed: () {


                          Navigator.pop(context);
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
            },
            icon: const Icon(Icons.more_horiz, color: Colors.white, size: 36,),
          ),
        );
      },
    );
  }
}
