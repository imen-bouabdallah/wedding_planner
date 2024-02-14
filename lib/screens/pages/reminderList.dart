import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Helpers.dart';
import 'package:wedding_planner/classes/Reminder.dart';
import 'package:wedding_planner/screens/addReminder.dart';
import 'package:wedding_planner/style/Theme.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({super.key});

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {

  List _reminders = [];
  late Stream<QuerySnapshot> _stream;


  Widget _createReminder(Reminder reminder){
    return Material(
      color: goldAccent,
      child: ListTile(
      
        title: Text(reminder.title),
        subtitle: reminder.description.isNotEmpty ? Text(reminder.description) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            reminder.date.hour != 0 && reminder.date.minute!=0 ?
            Text("${reminder.date.day.toString()}/${reminder.date.month.toString()}/${reminder.date.year.toString()}\n "
                "at ${reminder.date.hour.toString()}:${reminder.date.minute.toString()}",
              style: TextStyle(color: gold, fontSize: 14),) :
            Text("${reminder.date.day.toString()}/${reminder.date.month.toString()}/${reminder.date.year.toString()} ",
              style: TextStyle(color: gold, fontSize: 14),),
            //IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_active)),
            sideMenu('/addReminder', reminder)
          ],
        )
      
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _stream = db_reminder.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: StreamBuilder(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData){
              if(snapshot.connectionState == ConnectionState.active){
                _reminders = getReminders(snapshot);
                return ListView.separated(
                    itemCount: _reminders.length,
                    itemBuilder: (context, item){
                  return _createReminder(_reminders[item]);
                }, separatorBuilder: (BuildContext context, int index) => const SizedBox(
                  height: 10,
                ));
              }
            }
            else if(snapshot.hasError){
              print(snapshot.error.toString());
            }
            else return const Center(child: CircularProgressIndicator());

            return const SizedBox();
          },

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

List getReminders(snapshot){
  QuerySnapshot query = snapshot.data;
  return query.docs.map((e) => Reminder.fromSnapshot(e as DocumentSnapshot<Map<String, dynamic>>)).toList();
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
