import 'package:flutter/material.dart';

Future confirmDelete(context){
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("Are you sure you want to delete this reminder?"),
            ],
          ),
        ),
        actions: <Widget>[
          FilledButton(
            onPressed: () {
              Navigator.pop(context); //to close dialog
              Navigator.pop(context); //to close popup menu
            },
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () {

              Navigator.pop(context); //to close dialog
              Navigator.pop(context); //to close menu
            },
            child: const Text('Yes'),
          ),
        ],
      ));
}