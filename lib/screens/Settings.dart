import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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

          TextButton(
              onPressed: (){},
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Reminders  ",
                    style: TextStyle(
                        color: Colors.black
                    ),),
                  Switch(value: false, onChanged: (value){})
                ],
              )
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
                  Icon(Icons.link),
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
