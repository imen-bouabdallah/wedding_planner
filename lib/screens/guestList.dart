import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding_planner/classes/Guest.dart';

class Guest_list extends StatefulWidget {
  const Guest_list({Key? key}) : super(key: key);

  @override
  State<Guest_list> createState() => _Guest_listState();
}

class _Guest_listState extends State<Guest_list> {
  @override



  List guest_list = [Guest("guest name is very long so that we can test what would happend if hjghjgjgjhgjhgjh"),
    Guest("geust 2"),
    Guest("guest name3"),
    Guest.withInvite("guest name is very long so that we can test what would happend if hjghjgjgjhgjhgjh", '0555354', true),
    Guest("geust 44"),
    Guest("guest name3"),
    Guest("guest name is very long so that we can test what would happend if hjghjgjgjhgjhgjh"),
    Guest.withNumber("geust 47", '0555354'),
    Guest("guest name3"),
    Guest("guest name is  long"),
    Guest.withNumber("geust 2", '0555354'),
    Guest("guest name3"),
    Guest("guest name hjghjgjgjhgjhgjh"),
    Guest.withInvite("geust 2", '0555354', true),
    Guest("guest name3"),
  ];

  Container guest(Guest guest){
    return  Container(
      color:  guest.isInvited ? Colors.green : Colors.transparent,
      child: guest.isInvited ? ///if the guest is invited
      Row(
          children: [
            const SizedBox(width: 5,),
            Expanded(child: Text(guest.name)),
            const Text(
              'Invited',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),),
            const SizedBox(width: 10,),
          ]
      )
          : ///if guest not yet invited
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5,),
          Expanded(child: Text(guest.name)),
          //TODO if the number if availble else change the icon with a plus sign and the function would let you add the number
          guest.phoneNumber.isNotEmpty ? //if phone number is available
          IconButton(
            onPressed: () async {
              final call = Uri.parse('tel:${guest.phoneNumber}');
              if (await canLaunchUrl(call)) {
                launchUrl(call);
              } else {
                throw 'Could not launch $call';
              }
            },
            icon: const Icon(Icons.call),)
          : // if phone number not available
          IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.add_call)),
          const SizedBox(width: 5,),
          IconButton(
            onPressed: (){},
            icon: Icon(guest.isInvited ? Icons.email_outlined : Icons.email),),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest list'),
        //elevation: 5,
        shadowColor: Theme.of(context).shadowColor,
        scrolledUnderElevation: 4.0,
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
          const SizedBox(height:40,),
          for(int i=0; i<guest_list.length; i++)
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: guest(guest_list[i]),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          const SizedBox(height: 50),

        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
    );


  }
}