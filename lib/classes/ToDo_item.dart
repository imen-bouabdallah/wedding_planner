class ToDo_item{
  String _text;
  String _creator;
  String _assignedTo = '';
  bool _starred = false;
  bool _done = false;
  bool _assigned = false;


  ToDo_item(this._text, this._creator);

  bool get done => _done;

  String get assignedTo => _assignedTo;

  set assignedTo(String value) {
    _assignedTo = value;
  }

  set done(bool value) {
    _done = value;
  }

  bool get starred => _starred;

  set starred(bool value) {
    _starred = value;
  }

  String get creator => _creator;

  set creator(String value) {
    _creator = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  bool get assigned => _assigned;

  set assigned(bool value) {
    _assigned = value;
  }
}