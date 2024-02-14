import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  String _id;
  String _title;
  String _description;
  DateTime _date;


  Reminder(this._title, this._date, [this._description = "", this._id = '']);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }


  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  toJson(){
    return {
      "title" : _title,
      "date" : _date,
      "description" : _description
    };
  }


  factory Reminder.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    final date = DateTime.parse(data["date"] .toDate().toString());
    return Reminder(
      data["title"],
      date,
      data["description"],
      document.id,
    );
  }
}