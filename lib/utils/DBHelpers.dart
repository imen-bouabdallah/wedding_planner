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
import '../classes/Account.dart';


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
        else {
          Fluttertoast.showToast(msg: "error");
        }
      });

  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(msg: "error");
  }
}





///Database

deleteItem(String collection, element) async {
  DocumentReference doc = FirebaseFirestore.instance.collection(collection).doc(element.id);
  await doc.delete().then((value){
    Fluttertoast.showToast(msg: "Item Deleted");
  }).onError((error, stackTrace) {
    Fluttertoast.showToast(msg: "Error while deleting item");
  });
}

var db_guest = FirebaseFirestore.instance.collection('Guest');
var db_task = FirebaseFirestore.instance.collection('Tasks');
var db_shopItem = FirebaseFirestore.instance.collection('ShopItems');
var db_reminder = FirebaseFirestore.instance.collection('Reminders');
var db_user = FirebaseFirestore.instance.collection('Users');
var db_date = FirebaseFirestore.instance.collection('Date');

//////////////////////////////////////////////////////////// Guests



Future<List<Guest>> getAllGuest() async{
  final snapshot = await db_guest.get();
  final guestData = snapshot.docs.map((e) => Guest.fromSnapshot(e)).toList();
  return guestData;
}

createGuest(Guest guest, context) async {
  //check if the guest doesn't exist already
  await db_guest
      .where("name", isEqualTo: guest.name)
      .get().then(
          (value) {
            if(value.docs.isEmpty) saveGuest(guest, context);
            else Fluttertoast.showToast(msg: "Guest exists already");
          }).onError((error, stackTrace) {
            saveGuest(guest, context);
          }
    ).catchError((error, stackTrace){
      Fluttertoast.showToast(msg: "Error, something went wrong please try again");
    });

}

saveGuest(Guest guest, context){
  db_guest.add(guest.toJson()).whenComplete(
          (){
        Fluttertoast.showToast(msg: "new guest saved successfully");
        Navigator.pop(context);
      });
}

updateGuest(Guest guest){
  DocumentReference doc = db_guest.doc(guest.id);
  doc.update(guest.toJson());
}

getMenCount() {
  int men = 0;
  getAllGuest().then((List<Guest> value) {
    Guest val;
    for(val in value){
      men += val.menNumber;
    }
  });

  return men;
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

///////////////////////////////////////////////////////
class Date{
  String _id;
  DateTime _date;

  Date(this._date, [this._id = ""]);


  String get id => _id;

  toJson(){
    return {
      "date" : _date,
    };
  }

  factory Date.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return Date(
        DateTime.parse(data["date"] .toDate().toString()),
        document.id
    );
  }

  DateTime get date => _date;
}

updateDate(item, context){
  DocumentReference doc = db_date.doc(item.id);
  doc.update(item.toJson()).then((value){
    Fluttertoast.showToast(msg: "Date changed");
    Navigator.of(context).pop();
  }).onError((error, stackTrace) {
    Fluttertoast.showToast(msg: "Date not changed");
  });
}


