import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:wedding_planner/classes/Guest.dart';
import 'package:wedding_planner/classes/Reminder.dart';
import 'package:wedding_planner/classes/ToDo_item.dart';
import 'package:wedding_planner/classes/ShopItem.dart';
import 'package:wedding_planner/classes/User.dart';
import 'package:wedding_planner/screens/connect/login.dart';

import 'Account.dart';



Future confirmDelete(context, element ,String collection){
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
            },
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () {
              deleteItem(collection, element);
              Navigator.pop(context); //to close dialog
            },
            child: const Text('Yes'),
          ),
        ],
      ));
}


Future confirmLogout(context) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("Are you sure you want to logout of this account?"),
            ],
          ),
        ),
        actions: <Widget>[
          FilledButton(
            onPressed: () {
              Navigator.pop(context); //to close dialog
            },
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value){
              }).onError((error, stackTrace) { print("error");});

              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                      builder: (context) =>
                       Login()),
                      (route) => false);
            },
            child: const Text('Yes'),
          ),
        ],
      ));
}


Widget sideMenu(String route, argu /*String collection*/){
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
              onPressed: (){confirmDelete(context, argu, route/*, collection*/);            },
              child: const Text('Delete'))),
    ],
  );
}

///SignIn methods
Future SignIn(String email, String password, context) async{ //with email
  bool result = await InternetConnection().hasInternetAccess; //check internet connection
  
  if(result) {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password).then((value){
      Navigator.popAndPushNamed(
        context,
        '/',
      );
      Fluttertoast.showToast(msg: "Welcome!");
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "email or password incorrect");

    });

  }
  else{
    Fluttertoast.showToast(msg: "No internet connection!");
  }
}

Future signInWithNumber() async {
  bool result = await InternetConnection().hasInternetAccess; //check internet connection

  /*await FirebaseAuth.instance.signInWithPhoneNumber(

      );*/
}

signup(Account account, context, userName) async {
  try{

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: account.email, password: account.password)
          .then((value) {
        Fluttertoast.showToast(msg: "Account created successfully", toastLength: Toast.LENGTH_SHORT,);

        createUser(Users(userName, account.email, FirebaseAuth.instance.currentUser!.uid));

        Fluttertoast.showToast(msg: "Welcome $userName");
        Navigator.popAndPushNamed(context, "/");
      }
      ).onError((error, stackTrace) {
        if(error == 'ERROR_EMAIL_ALREADY_IN_USE') {
          Fluttertoast.showToast(msg: "Account exists already!");
        }
        else Fluttertoast.showToast(msg: "error");
      });

  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(msg: "error");
  }
}





///Database

deleteItem(String collection, element){
  DocumentReference doc = FirebaseFirestore.instance.collection(collection).doc(element.id);
  doc.delete();
}

var db_guest = FirebaseFirestore.instance.collection('Guest');
var db_task = FirebaseFirestore.instance.collection('Tasks');
var db_shopItem = FirebaseFirestore.instance.collection('ShopItems');
var db_reminder = FirebaseFirestore.instance.collection('Reminders');
var db_user = FirebaseFirestore.instance.collection('Users');
//////////////////////////////////////////////////////////// Guests


Future<Guest> getGuest(String name) async{
  final snapshot = await db_guest.where('name', isEqualTo: name).get();
  final guestData = snapshot.docs.map((e) => Guest.fromSnapshot(e)).single;
  return guestData;
}

Future<List<Guest>> getAllGuest() async{
  final snapshot = await db_guest.get();
  final guestData = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
  return guestData;
}

updateGuest(Guest guest){
  DocumentReference doc = db_guest.doc(guest.id);
  doc.update(guest.toJson());
}



/////////////////////////////////////////////////////// Tasks
createTask(ToDo_item task) async {

  await db_task.add(task.toJson()).whenComplete(
          (){
        Fluttertoast.showToast(msg: "new task saved successfully");
      }
  ).catchError((error, stackTrace){
    Fluttertoast.showToast(msg: "Error, something went wrong please try again");
  });
}


Future<List<ToDo_item>> getAllTasks() async{
  final snapshot = await db_task.get();
  final taskData = snapshot.docs.map((e) => ToDo_item.fromSnapshot(e)).toList();
  return taskData;
}

updateTask(ToDo_item todoItem){
  DocumentReference doc = db_guest.doc(todoItem.id);
  doc.update(todoItem.toJson());
}


////////////////////////////////// Shop Items
createShopItem(ShopItem item, context) async {

  await db_shopItem.add(item.toJson()).whenComplete(
          (){
        Fluttertoast.showToast(msg: "new item saved successfully");
        Navigator.pop(context);
      }
  ).catchError((error, stackTrace){
    Fluttertoast.showToast(msg: "Error, something went wrong ");
  });
}


/////////////////////////////////// Reminder
createReminder(Reminder reminder, context) async {

  await db_reminder.add(reminder.toJson()).whenComplete(
          (){
        Fluttertoast.showToast(msg: "new reminder created successfully");
        Navigator.pop(context);
      }
  ).catchError((error, stackTrace){
    Fluttertoast.showToast(msg: "Error, something went wrong please try again");
  });
}


/////////////////////////////////////////// User

createUser(Users user) async {

  await db_user.add(user.toJson()).catchError((error, stackTrace){
    Fluttertoast.showToast(msg: "Error, something went wrong please try again");
  });
}

Future<Users> getUser(String id) async{
  final snapshot = await db_user.where('id', isEqualTo: id).get();
  final user = snapshot.docs.map((e) => Users.fromSnapshot(e)).single;
  return user;
}

getUserName(String id)  async {
  final snapshot = await db_user.where('id', isEqualTo: id).get();
  final user = snapshot.docs.map((e) => Users.fromSnapshot(e)).single;
  print(user.userName);
  print("ze here");
  return user.userName;
}

String convertUserName(id){
  String a = getUserName(id).toString();
  return a;
}

