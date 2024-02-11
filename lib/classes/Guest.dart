

import 'package:cloud_firestore/cloud_firestore.dart';

class Guest{
  String _id;
  String _name;
  String? _phoneNumber= '';
  bool _isInvited;
  String _type;
  int _menNumber ;
  int _womenNumber ;

  Guest([this._name ="", this._type ='', this._phoneNumber, this._womenNumber = 0, this._menNumber = 1, this._isInvited = false, this._id ='']);


  int get menNumber => _menNumber;

  set menNumber(int value) {
    _menNumber = value;
  }

  bool get isInvited => _isInvited;

  set isInvited(bool value) {
    _isInvited = value;
  }

  String? get phoneNumber => _phoneNumber;

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  int get womenNumber => _womenNumber;

  set womenNumber(int value) {
    _womenNumber = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  toJson(){
    return {
      "name" : _name,
      "phoneNumber" : _phoneNumber,
      "type" : _type,
      "isInvited" : _isInvited,
      "menNumber" : _menNumber,
      "womenNumber" : _womenNumber,
    };
  }

  factory Guest.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return Guest(
      data["name"],
      data["type"],
      data["phoneNumber"],
      data["womenNumber"],
      data["menNumber"],
      data["isInvited"],
      document.id,
    );
  }
}


