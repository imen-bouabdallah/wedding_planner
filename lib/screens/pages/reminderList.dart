import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Helpers.dart';
import 'package:wedding_planner/classes/Reminder.dart';
import 'package:wedding_planner/screens/addReminder.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({super.key});

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {

  final List<Reminder> _reminders = [Reminder('do something', DateTime(2024, 5, 20), DateTime(0,0,0,12,11))];


  Widget _createReminder(Reminder reminder){
    return ListTile(

      title: Text(reminder.title),
      subtitle: Text("${reminder.date.day.toString()}/${reminder.date.month.toString()}/${reminder.date.year.toString()} "
          "at ${reminder.time?.hour.toString()}:${reminder.time?.minute.toString()}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_active)),
          sideMenu('/addReminder', reminder)
        ],
      )

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: ListView.builder(
          itemCount: _reminders.length,
           itemBuilder: (context, item){
             return _createReminder(_reminders[item]);
           }
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(_createRoute());
        },
        child: const Icon(Icons.notification_add),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const AddReminder(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
