import 'package:wedding_planner/classes/User.dart';

class ToDo_item{
  String _text;
  User _creator;
  bool _private = true; //is the item private or public
  bool _done = false;


  ToDo_item(this._text, this._creator);

  ToDo_item.withPrivacy(this._text , this._creator, this._private);

  bool get done => _done;

  set done(bool value) {
    _done = value;
  }


  User get creator => _creator;

  set creator(User value) {
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

  toJson(){
    return {
      "text" : _text,
      "done" : _done,
      "private" : _private,
      "creator" : _creator,
    };
  }

}