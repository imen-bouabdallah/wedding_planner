import 'dart:core';
import 'package:flutter/material.dart';


class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  DateTime _reminderDate = DateTime.now();
  bool _activeDate = false;

  final _dateControler = TextEditingController();
  final _timeControler = TextEditingController();
  final _titleControler = TextEditingController();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _reminderDate,
        firstDate: _reminderDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != _reminderDate) {
      _dateControler.text = picked.day.toString() + '/' + picked.month.toString() + '/' + picked.year.toString();

    }
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),

    );
    if (picked != null) {
      ///TODO
      //if(!_dateControler.text.isEmpty && _dateControler.text)
      _timeControler.text =
          picked.hour.toString() + ':' + picked.minute.toString();
    }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create reminder"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(4),

        child: Column(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              controller: _titleControler,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter reminder\'s title',
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _dateControler,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter the date',
                    ),
                  ),
                ),
                
                SizedBox(width: 10,),
                Expanded(
                  child: IconButton(onPressed: () {
                    _selectDate(context);
                  },
                      icon: const Icon(Icons.calendar_month)),
                )
              ],
            ),
            SizedBox(height:10),
           Row(
              children: [
                Expanded(
                  child: TextFormField(
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
                    activeColor: Colors.green,
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
