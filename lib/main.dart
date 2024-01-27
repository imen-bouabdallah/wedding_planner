import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/Settings.dart';
import 'package:wedding_planner/screens/guestList.dart';
import 'package:wedding_planner/screens/reminderList.dart';
import 'package:wedding_planner/screens/todoList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wedding planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key /*,required this.title*/});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime date =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour);
  DateTime weddingDate = DateTime.utc(2024, DateTime.july, 6, 0);
  int CurrentButton= 0; //for bottom navigation bar -- current selected button

  countdown() {
    ///calculate the countdown to the weeding
    final diffrence = weddingDate.difference(date).inDays;
    int diffrenceH = weddingDate.difference(date).inHours;
    int diffrencerestH = ((diffrenceH/24 - diffrence)*24).round();
    diffrenceH = weddingDate.difference(date).inMinutes;
    int diffrenceRestM =( ( (diffrenceH/60)/24 - diffrence)*60 - diffrencerestH).round();

    return [diffrence, diffrencerestH, diffrenceRestM];
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Settings()),
            );
          }, icon: const Icon(Icons.settings)),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            CurrentButton = index;


            if (index==0){ //reminders
              Navigator.push(
                context,
                  MaterialPageRoute(builder: (context) => const ReminderList()),
              );

            }
            else if (index==1){ //shopping list

            }
            else if (index==2){ //guests
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Guest_list()),
              );
            }
            else if (index==3){ //todos
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Todo_list()),
              );
            }
          });
        },
        selectedIndex: CurrentButton, //this change the indicator when a button is pressed
        destinations: const <Widget>[ //the buttons
          NavigationDestination(
            selectedIcon: Icon(Icons.notifications), //the icon when the button is active
            icon: Icon(Icons.notifications_outlined),
            label: 'Reminder', //text under icon
          ),

          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_bag), //the icon when the button is active
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Budget', //text under icon
          ),

          NavigationDestination(
            selectedIcon: Icon(Icons.person), //the icon when the button is active
            icon: Icon(Icons.person_outline),
            label: 'Guest', //text under icon
          ),

          NavigationDestination(
            selectedIcon: Icon(Icons.check_box), //the icon when the button is active
            icon: Icon(Icons.check_box_outlined),
            label: 'ToDo list', //text under icon
          ),

        ],

      ),
      body:  Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Image(),
                Text('${countdown()[0]}days : ${countdown()[1]} hours : ${countdown()[2]} minutes '),

              ],
            ),

          ),
          const Expanded( child: Text("XX Guests not invited Yet")),

        ],
      ),

    );
  }
}
