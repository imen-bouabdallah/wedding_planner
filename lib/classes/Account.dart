
import 'package:cloud_firestore/cloud_firestore.dart';

class Account{
  String _id;
  String _email;
  String _password;

  Account([ this._email = "",
    this._password = "",
    this._id = ""]);

  String get id => _id;

  String get email => _email;

  String get password => _password;

  toJson(){
    return {
      "id" : _id,
      "email" : _email,
      "password" : _password,
    };
  }

  factory Account.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return Account(
      data["email"],
      data["password"],
      document.id,
    );
  }


  static Account fromJason(Map<String, dynamic> json) => (
      Account(
        json["email"],
        json["password"],
        json['id']
      )
  );

}