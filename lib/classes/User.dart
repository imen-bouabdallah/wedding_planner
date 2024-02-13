import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String _id;
  String _email;
  String _password;

  Users([ this._email = "", this._password = "", this._id = ""]);

  String get id => _id;

  set id(String value) {
    _id = value;
  }


  String get email => _email;

  set email(String value) {
    _email = value;
  }


  String get password => _password;

  set password(String value) {
    _password = value;
  }

  toJson(){
    return {
      "id" : _id,
      "email" : _email,
      "password" : _password,
    };
  }

  factory Users.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return Users(
      data["email"],
      data["password"],
      document.id,
    );
  }


}