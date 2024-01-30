import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Reminder.dart';
import 'package:wedding_planner/screens/addReminder.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({super.key});

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {

  final List<Reminder> _reminders = [Reminder('do something', DateTime(2024, 5, 20))];

  Future _confirmDelete(){
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Are you sure you want to delete this reminder?"),
              ],
            ),
          ),
          actions: <Widget>[
            FilledButton(
              onPressed: () {
                Navigator.pop(context); //to close dialog
                Navigator.pop(context); //to close popup menu
              },
              child: const Text('No'),
            ),
            FilledButton(
              onPressed: () {

                Navigator.pop(context); //to close dialog
                Navigator.pop(context); //to close menu
              },
              child: const Text('Yes'),
            ),
          ],
        ));
  }

  Widget _createReminder(Reminder reminder){
    return ListTile(

      title: Text(reminder.title),
      subtitle: Text("${reminder.date.day.toString()}/${reminder.date.month.toString()}/${reminder.date.year.toString()} at ${reminder.date.hour.toString()}:${reminder.date.minute.toString()}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_active)),
          PopupMenuButton(
            itemBuilder: (context)=> <PopupMenuEntry>[
              PopupMenuItem(
                  child: TextButton(
                      onPressed: (){
                        Navigator.pop(context);//close the popup menu
                        Navigator.pushNamed(
                        context,
                        '/addReminder',
                          arguments: reminder
                      );
                      },
                      child: const Text('Edit'))),
              PopupMenuItem(
                  child: TextButton(
                      onPressed: (){_confirmDelete();            },
                      child: const Text('Delete'))),
            ],
          ),
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
      body: ListView.builder(
        itemCount: _reminders.length,
         itemBuilder: (context, item){
           return _createReminder(_reminders[item]);
         }
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
