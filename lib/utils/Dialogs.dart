import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:wedding_planner/utils/DBHelpers.dart';
import 'package:wedding_planner/screens/connect/login.dart';
import 'package:wedding_planner/style/Theme.dart';
import 'package:wedding_planner/utils/Menus.dart';

Future confirmDelete(context, element ,String collection){
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("Are you sure you want to delete this item?"),
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
                  MaterialPageRoute(
                      builder: (context) =>
                      const Login()),
                      (route) => false);
            },
            child: const Text('Yes'),
          ),
        ],
      ));
}


Future updateWeddingDate(context, String id) {
  final _dateControler = TextEditingController();
  bool _validateDate = false;
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Change wedding date'),
        content: TextField(
          controller: _dateControler,
          decoration:  InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Enter the date',
            errorText: _validateDate ? "Value Can't Be Empty" : null,
          ),

          onTap: (){
            _selectDate(context, _dateControler);
          },
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              _dateControler.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {

              if(_dateControler.text.isNotEmpty){
                var format = DateFormat("dd-MM-yyyy");
                var item = Date(format.parse("${_dateControler.text}"), id);
                updateDate(item, context);

                _dateControler.clear();

                Navigator.of(context).pop();
              }
              else
                Fluttertoast.showToast(msg: "field empty");

            },
            child: const Text('Add'),
          ),
        ],
      )
  );

}

Future<void> _selectDate(BuildContext context, _dateControler) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101));
  if (picked != null && picked != DateTime.now()) {
    _dateControler.text = '${picked.day}-${picked.month}-${picked.year}';

  }
}


Future sendInvite(context) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Send Invitation', ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
             OutlinedButton(
                      onPressed: (){
                        Navigator.pop(context);
                        shareInvite(context, 'invite/invitation_ar.png');},
                      child: Text('Arabic Invitation', style: TextStyle(color: gold))),
              OutlinedButton(
                      onPressed: (){
                        Navigator.pop(context);
                        shareInvite(context, 'invite/invitation_fr.png');},
                      child:  Text('French invitation', style: TextStyle(color: gold),)),

            ],
          ),
        ),
      ));
}