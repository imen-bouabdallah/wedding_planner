import 'dart:core';
import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Reminder.dart';
import 'package:wedding_planner/style/Theme.dart';


class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {


  final DateTime _today = DateTime.now();
  bool _activeDate = false, _validateTitle = false, _validateDate = false;

  final _dateControler = TextEditingController();
  final _timeControler = TextEditingController();
  final _titleControler = TextEditingController();

  var reminder;


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _today,
        firstDate: _today,
        lastDate: DateTime(2101));
    if (picked != null && picked != _today) {
      _dateControler.text = '${picked.day}/${picked.month}/${picked.year}';

    }
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),

    );
    if (picked != null) {
      ///TODO check if the date is today check the time
      //if(!_dateControler.text.isEmpty && DateTime.parse(_dateControler.text)==_today)
      //_timeControler.text = '';
      _timeControler.text =
          '${picked.hour}:${picked.minute}';
    }
  }

  _save(){
    setState(() {
      _validateTitle = _titleControler.text.isEmpty;
      _validateDate = _dateControler.text.isEmpty;
    });
  }



  _confirmExit() {
    showDialog<void>(
        context: context,
        //T: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Save or discard changes?'),
            actionsAlignment: MainAxisAlignment.start,
            backgroundColor: gold,
            actions: <Widget>[
              TextButton(
                onPressed: () {

                },
                child: const Text('Cancel'),
              ),
              const VerticalDivider(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Discard'),
              ),
              const VerticalDivider(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // _addTodoItem(_textFieldController.text);
                },
                child: const Text('Save'),
              ),
            ],
          );
        }
    );
  }

  @override
  void dispose() {
    super.dispose();

    _dateControler.dispose();
    _timeControler.dispose();
    _titleControler.dispose();
  }


  @override
  Widget build(BuildContext context) {

    if(ModalRoute.of(context)!.settings.arguments!=null) {
      //if it's an edit there is a passed data
      reminder = ModalRoute.of(context)!.settings.arguments as Reminder; //get the passed data
    }

    if (reminder.toString().isNotEmpty && reminder != null){
      _titleControler.text = reminder.title;
      _dateControler.text = reminder.date.toString();
      if (reminder.time !=null) {
        _timeControler.text = reminder.time.toString();
      }

    }
    return Scaffold(
      appBar: AppBar(
        title: reminder.toString().isEmpty? const Text("Create reminder") : const Text("Edit reminder"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if(_dateControler.text.isNotEmpty || _titleControler.text.isNotEmpty || _timeControler.text.isNotEmpty) {
              _confirmExit();
            } else {
              Navigator.pop(context);
            }
          },
        ),

        actions: [
          IconButton(
              onPressed: () {
                _save();
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(4),

        child: Column(
          children: [
            const SizedBox(height: 10,),
            TextField(
              controller: _titleControler,
              decoration:  InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Enter reminder\'s title',
                errorText: _validateTitle ? "Value Can't Be Empty" : null,
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateControler,
                    decoration:  InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Enter the date',
                      errorText: _validateDate ? "Value Can't Be Empty" : null,
                    ),

                    onTap: (){
                      _selectDate(context);
                    },
                  ),
                ),

                const SizedBox(width: 10,),
                const Icon(Icons.calendar_month)
              ],
            ),
            const SizedBox(height:10),
           Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _timeControler,
                    enabled: _activeDate,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter the time',

                    ),

                    onTap: (){
                      _selectTime(context);
                    },
               ),
                ),


                Expanded(
                  child: Switch(
                    // This bool value toggles the switch.
                    value: _activeDate,
                    activeColor: green_,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        _activeDate = value;
                      });
                    },
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
