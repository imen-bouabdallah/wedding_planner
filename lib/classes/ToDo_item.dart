import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_planner/classes/User.dart';

class ToDo_item{
  String _id;
  String _text;
  Users _creator;
  bool _private = true; //is the item private or public
  bool _done = false;


  ToDo_item(this._text, this._creator, [this._private = true, this._done = false, this._id = '']);

  bool get done => _done;

  set done(bool value) {
    _done = value;
  }


  Users get creator => _creator;

  set creator(Users value) {
    _creator = value;
  }

  bool get private => _private;

  set private(bool value) {
    _private = value;
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
      "private" : _private,
      "creator" : _creator,
    };
  }

  factory ToDo_item.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return ToDo_item(
      data["text"],
      data["creator"],
      data["private"],
      data["done"],
      document.id,
    );
  }

}