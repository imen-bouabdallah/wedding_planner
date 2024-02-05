import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/homeScreen.dart';

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


Widget sideMenu(String route, argu){
  return PopupMenuButton(
    itemBuilder: (context)=> <PopupMenuEntry>[
      PopupMenuItem(
          child: TextButton(
              onPressed: (){
                Navigator.pop(context);//close the popup menu
                Navigator.pushNamed(
                    context,
                    route,
                    arguments: argu
                );
              },
              child: const Text('Edit'))),
      PopupMenuItem(
          child: TextButton(
              onPressed: (){confirmDelete(context);            },
              child: const Text('Delete'))),
    ],
  );
}

///SignIn methods
Future SignIn(String email, String password, context) async{ //with email
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

  Navigator.push(
    context,
    MaterialPageRoute(builder: (
        context) => const HomeScreen()),
  );
}