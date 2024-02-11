import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  String _id;
  String _title;
  DateTime _date;
  DateTime? _time;


  Reminder(this._title, this._date, [this._time, this._id = '']);

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


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  toJson(){
    return {
      "title" : _title,
      "date" : _date,
      "time" : _time,
    };
  }


  factory Reminder.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return Reminder(
      data["title"],
      data["date"],
      data["time"],
      document.id,
    );
  }
}