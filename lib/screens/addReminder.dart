import 'dart:core';
import 'package:flutter/material.dart';
import 'package:wedding_planner/style/Theme.dart';


class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {


  final DateTime _today = DateTime.now();
  bool _activeDate = false;

  final _dateControler = TextEditingController();
  final _timeControler = TextEditingController();
  final _titleControler = TextEditingController();


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

  }



  _confirmExit() {
    showDialog<void>(
        context: context,
        //T: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Save or discard changes?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Discard'),
              ),
              const Divider(),
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
    final data = ModalRoute.of(context)?.settings.arguments; //get the passed data
    return Scaffold(
      appBar: AppBar(
        title: data.toString().isEmpty? const Text("Create reminder") : const Text("Edit reminder"),
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
            TextFormField(
              controller: _titleControler,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter reminder\'s title',
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _dateControler,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter the date',
                      fillColor: Colors.blue
                    ),
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(width: 10,),
                IconButton(onPressed: () {
                  _selectDate(context);
                },
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
            const SizedBox(height:10),
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
