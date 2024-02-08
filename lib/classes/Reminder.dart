class Reminder {
  String _title;
  DateTime _date;
  DateTime? _time;


  Reminder(this._title, this._date, [this._time]);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  DateTime? get time => _time;

  set time(DateTime? value) {
    _time = value;
  }

  toJson(){
    return {
      "title" : _title,
      "date" : _date,
      "time" : _time,
    };
  }
}