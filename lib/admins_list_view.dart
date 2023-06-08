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
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.white, size: 36,),
          ),
        );
      },
    );
  }
}
