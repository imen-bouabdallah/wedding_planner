import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wedding_planner/utils/DBHelpers.dart';
import 'package:wedding_planner/screens/pages/guestList.dart';
import 'package:wedding_planner/screens/pages/reminderList.dart';
import 'package:wedding_planner/screens/pages/shoppingList.dart';
import 'package:wedding_planner/screens/pages/todoList.dart';
import 'package:wedding_planner/style/Theme.dart';
import 'package:wedding_planner/utils/Dialogs.dart';
import 'package:wedding_planner/utils/Menus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime date =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour);
  DateTime weddingDate = DateTime.utc(2024, DateTime.july, 6, 0);
  int CurrentButton= 0; //for bottom navigation bar -- current selected button
  late String dateId;



  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope( //this widget allows overriding back button
      canPop: true,
      onPopInvoked: (didPop){
        FlutterExitApp.exitApp();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Wedding Planer"),
          //automaticallyImplyLeading: false,
          actions: [
           IconButton(onPressed: (){
            confirmLogout(context);
          }, icon: const Icon(Icons.logout)),
          ],
        ),
        drawer: NavigationDrawer(
          children:  [
            SafeArea(child:
             DrawerHeader(
                decoration: BoxDecoration(
                  color: gold
                ),
                child :
                const Stack(
                  children: [ Positioned(
                    bottom: 8.0,
                    left: 4.0,
                    child:  Text("Options", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                  ),]
                ),
             )),

            TextButton(onPressed:(){
              updateWeddingDate(context, dateId);
            },
                child: const Row(
                  children: [
                    Icon(Icons.date_range_outlined, color: Colors.black,),
                    SizedBox(width: 10,),
                    Text("Change wedding date",
                      style: TextStyle(
                          color: Colors.black
                      ),),
                  ],
                )
            ),
            TextButton(onPressed: (){
              sendInvite(context);
            },
                child: const Row(
                  children: [
                    Icon(Icons.link, color: Colors.black,),
                    SizedBox(width: 10,),
                    Text("Share event  ",
                      style: TextStyle(
                          color: Colors.black
                      ),),

                  ],
                )),
            Divider(color: gold),
            TextButton(
                onPressed: (){},
                child: const Row(
                  children: [
                    Icon(Icons.delete_forever,
                      color: Colors.red),
                    SizedBox(width: 10,),
                    Text("Delete event  ",
                      style: TextStyle(
                          color: Colors.red
                      ),),

                  ],
                )
            ),
            TextButton(
                onPressed: (){confirmLogout(context);},
                child: const Row(
                  children: [
                    Icon(Icons.logout,color: Colors.black,),
                    SizedBox(width: 10,),
                    Text("Logout ", style: TextStyle(color: Colors.black),),
                  ],
                )
            ),
          ],
        ),
      
        body:  SingleChildScrollView(
          child: Column(
      
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IgnorePointer(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(),
                      color: platinum
                  ),
      
                  child: weddingDatePreview(),

                ),
              ),
              const SizedBox(height: 15,),
              UnconstrainedBox(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)
                  ),
                  child: Center(
                    child: StreamBuilder(
                        stream: FirebaseFirestore
                            .instance
                            .collection('Guest')
                            .where('isInvited', isEqualTo: false)
                            .snapshots(),
                        builder: (context, snapshot)  {
                          if(snapshot.hasData){
                
                            if(snapshot.connectionState == ConnectionState.active){
                              return Text("${snapshot.data?.docs.length} Guests not yet invited!",
                                style:  TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  color: gold
                                ),
                              );
                            }
                            else if (snapshot.hasError){
                              return Center(child: Text(snapshot.error.toString()),);
                            }
                          }
                          return const Center(child: Text("Connection problem"),);
                        }),
                  ),
                ),
              ),
      
            ],
          ),
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
      
      ),
    );
  }

  weddingDatePreview(){
    return StreamBuilder(
        stream: FirebaseFirestore
        .instance
        .collection('Date')
        .snapshots(),
    builder: (context, snapshot)  {
    if(snapshot.hasData){

    if(snapshot.connectionState == ConnectionState.active){
      var stamp = snapshot.data!.docs.map((e) => Date.fromSnapshot(e)).toList();
      dateId = stamp[0].id;
      weddingDate =  stamp[0].date;
      return Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(weddingDate.year, weddingDate.month, 1),
              lastDay: DateTime.utc(weddingDate.year, weddingDate.month+1, 1),
              focusedDay: weddingDate,
              currentDay: weddingDate,
              pageAnimationEnabled: false,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false
              ),
              calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                      color: gold,
                      shape: BoxShape.circle
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  color: goldAccent
              ),
              padding: const EdgeInsets.all(3),
              child: CountDownText(
                due: weddingDate,
                finishedText: "Done",
                showLabel: true,
                longDateName: true,
                daysTextLong: " DAYS ",
                hoursTextLong: " HOURS ",
                minutesTextLong: " MINUTES ",
                secondsTextLong: " SECONDS ",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),

              ),
            ),
            const SizedBox(height: 4,)

          ]
      )    ;
    }
    else if (snapshot.hasError){
      return Center(child: Text(snapshot.error.toString()),);
    }
    }
    return const Center(child: Text("Connection problem"),);
    });


  }



}
