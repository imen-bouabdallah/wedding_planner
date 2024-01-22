import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Guest.dart';

class Guest_list extends StatefulWidget {
  const Guest_list({Key? key}) : super(key: key);

  @override
  State<Guest_list> createState() => _Guest_listState();
}

class _Guest_listState extends State<Guest_list> {
  @override
  final guest_list = [Guest("guest name"),
    Guest.withNumber("geust 2", 0555354),
    Guest("guest name3")
  ];

  Container guest(Guest guest){
    return  Container(
      color:  guest.isInvited ? Colors.green : Colors.transparent,
      child: guest.isInvited ?
      Row(
          children: [
            Text(guest.name),
            const Text(
              'Invited',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),),
          ]
      )
          :
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(guest.name),
          const SizedBox(width: 5,),
          IconButton(onPressed: (){}, icon: const Icon(Icons.call),),
          const SizedBox(width: 5,),
          IconButton(onPressed: (){}, icon: Icon(guest.isInvited ? Icons.email_outlined : Icons.email),),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest list'),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.more_vert) ),
        ],
      ),
      body: ListView(
        children: [
          for(int i=0; i<guest_list.length; i++)
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    ),
                  ),
                  child: guest(guest_list[i]),
                ),
                const SizedBox(height: 5,),
              ],
            ),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
    );


  }
}
