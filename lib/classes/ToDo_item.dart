class ToDo_item{
  String _text;
  bool _private = false; //is the item private or public
  bool _done = false;


  ToDo_item(this._text);

  ToDo_item.withPrivacy(this._text, this._private);

  bool get done => _done;

  set done(bool value) {
    _done = value;
  }




  bool get private => _private;

  set private(bool value) {
    _private = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

}