import 'package:flutter/material.dart';
import 'package:wedding_planner/style/Theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _reminder = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(onPressed:(){},
              child:  const Text("Change wedding date",
                style: TextStyle(
                    color: Colors.black
                ),)
          ),

          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Reminders  ",
                style: TextStyle(
                    color: Colors.black,
                  fontWeight: FontWeight.bold
                ),),
              Switch(
                  value: _reminder,
                  activeColor: green_,
                  onChanged: (isOn){
                    _reminder = isOn;
                  })
            ],
          ),


          const Divider(),

          TextButton(onPressed: (){},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Share event  ",
                    style: TextStyle(
                        color: Colors.black
                    ),),
                  Icon(Icons.link, color: Colors.black,),
                ],
              )),

          const Divider(),

          TextButton(
              onPressed: (){},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Delete event  ",
                    style: TextStyle(
                        color: Colors.red
                    ),),
                  Icon(Icons.delete_forever,
                      color: Colors.red),
                ],
              )
          ),

          const Divider(),

        ],
      ),
    );
  }
}

