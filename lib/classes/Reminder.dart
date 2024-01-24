class Reminder {
  String _title;
  DateTime _date;


  Reminder(this._title, this._date);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }
}