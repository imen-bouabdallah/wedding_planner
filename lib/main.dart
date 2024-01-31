
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_planner/screens/shoppingList.dart';
import 'package:wedding_planner/style/Theme.dart';
import 'package:wedding_planner/screens/Settings.dart';
import 'package:wedding_planner/screens/addGuest.dart';
import 'package:wedding_planner/screens/addReminder.dart';
import 'package:wedding_planner/screens/guestList.dart';
import 'package:wedding_planner/screens/reminderList.dart';
import 'package:wedding_planner/screens/todoList.dart';

void main() {
  runApp(const ProviderScope(child:  MyApp()));
}

//to be able to use pushNamed
Map<String, WidgetBuilder> routes = {
  "/": (context) => const MyHomePage(),
  "/addReminder": (context) => const AddReminder(),
  "/addGuest" : (context)=> const AddGuest(),

};

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final appThemeProvider = StateProvider<bool>((ref) => false);
    return MaterialApp(
      title: 'Wedding planner',
      theme: getAppTheme(context, ref.watch(appThemeProvider)),
      /* ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),*/
     // home: const MyHomePage(), //specified in route
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: "/",
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: const Text("Wedding Planer"),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Shopping()),
              );
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
            height: 350,
            child: Stack(
              children: [
                Image.asset('assets/invite/invitation_fr.png',
                fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 50,
                    left: 20,
                    right: 0,
                    top: 270,
                    child:
                    CountDownText(
                      due: weddingDate,
                      finishedText: "Done",
                      showLabel: true,
                      longDateName: true,
                      daysTextLong: " DAYS ",
                      hoursTextLong: " HOURS ",
                      minutesTextLong: " MINUTES ",
                      secondsTextLong: " SECONDS ",
                      style: TextStyle(color: Colors.black),

                    )
                      /*Text('${countdown()[0]}days : ${countdown()[1]} hours : ${countdown()[2]} minutes\n ',
                         style:TextStyle(
                           fontSize: 24,
                          // backgroundColor: Colors.black,
                           background: Paint()..color=Colors.black,
                           color: Colors.white
                    ) ,
                      strutStyle: const StrutStyle(height: 2,forceStrutHeight: true),)*/
                ),

              ],
            ),

          ),
          const Expanded( child: Text("XX Guests not invited Yet")),

        ],
      ),

    );
  }
}
