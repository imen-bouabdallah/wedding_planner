import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo_item{
  String _id;
  String _text;
  String _creator;
  bool _private = true; //is the item private or public
  bool _done = false;


  ToDo_item(this._text, this._creator, [ this._done = false, this._id ='']);

  bool get done => _done;

  set done(bool value) {
    _done = value;
  }


  String get creator => _creator;

  set creator(String value) {
    _creator = value;
  }



  String get text => _text;

  set text(String value) {
    _text = value;
  }


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  toJson(){
    return {
      "text" : _text,
      "done" : _done,
      "creator" : _creator,
    };
  }

  factory ToDo_item.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return ToDo_item(
      data["text"],
      data["creator"],
      data["done"],
      document.id,
    );
  }

}