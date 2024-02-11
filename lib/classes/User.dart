import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String _id;
  String _email;
  String _phoneNumber;
  String _userName;

  Users([this._userName = "", this._email = "", this._phoneNumber = "", this._id = ""]);

  String get id => _id;

  set id(String value) {
    _id = value;
  }


  String get email => _email;

  set email(String value) {
    _email = value;
  }

  toJson(){
    return {
      "id" : _id,
      "email" : _email,
      "phoneNumber" : _phoneNumber,
      "userName" : _userName,
    };
  }

  factory Users.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return Users(
      data["userName"],
      data["email"],
      data["phoneNumber"],
      document.id,
    );
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }
}