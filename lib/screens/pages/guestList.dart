import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding_planner/classes/Helpers.dart';
import 'package:wedding_planner/classes/Guest.dart';
import 'package:wedding_planner/screens/pages/detailedGuestList.dart';
import 'package:wedding_planner/style/Theme.dart';
import 'package:wedding_planner/screens/addGuest.dart';
import 'package:wedding_planner/utils/Dialogs.dart';
import 'package:wedding_planner/utils/Menus.dart';

class Guest_list extends StatefulWidget {
  const Guest_list({super.key});

  @override
  State<Guest_list> createState() => _Guest_listState();
}

class _Guest_listState extends State<Guest_list> {
  @override
  final _phoneNumberController = TextEditingController();

  final CollectionReference _refGuestList = FirebaseFirestore.instance.collection('Guest');
  late Stream<QuerySnapshot> _streamGuestList;

  List guestList = [];

  late int sort;


  @override
  void initState() {
     super.initState();
     _streamGuestList = _refGuestList.snapshots();
     sort =0;

  }

  @override
  void dispose() {
   _phoneNumberController.dispose();
    super.dispose();
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
          /*IconButton(
              onPressed: (){},
              icon: const Icon(Icons.search)),*/
          PopupMenuButton(
            icon: const Icon(Icons.sort) ,
            itemBuilder: (context) =>
            <PopupMenuEntry>[
              PopupMenuItem(
                  onTap: (){
                    setState(() {
                      sort = 1;
                    });
                  },
                  child: const Text('Sort A to Z', style: TextStyle(color: Colors.white),)),
              PopupMenuItem(
                  onTap: (){
                    setState(() {
                      sort = 2;
                    });
                  },
                  child: const Text('Sort Z to A', style: TextStyle(color: Colors.white),)),
              PopupMenuItem(
                  onTap: (){
                    setState(() {
                      sort = 3;
                    });
                  },
                  child: const Text('Invited', style: TextStyle(color: Colors.white),)),
              PopupMenuItem(
                  onTap: (){
                    setState(() {
                      sort = 4;
                    });
                  },
                  child: const Text('Non-Invited', style: TextStyle(color: Colors.white),)),
            ],
          ),

          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const DetailedList()),
                );
              },

              icon: const Icon(Icons.list_alt) ),
        ],
      ),


      body: Column(
        children: [
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              inviteMenu(),
            ]
          ),

          const SizedBox(height: 10,),
          StreamBuilder<QuerySnapshot>(
              stream:  _streamGuestList,
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                else if(snapshot.connectionState == ConnectionState.active){
                  guestList = getGuests(snapshot);

                  switch(sort){
                    case 1:
                      guestList.sort((a, b) {
                        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                      });
                      break;
                    case 2:
                      guestList.sort((a, b) {
                        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
                      });
                      break;
                    case 3:
                      guestList.sort((a, b)  {
                        if(b.isInvited) {
                          return 1;
                        }
                        return -1;
                      });
                      break;
                    case 4:
                      guestList.sort((a, b)  {
                        if(a.isInvited) {
                          return 1;
                        }
                        return -1;
                      });
                      break;
                    default:
                      break;
                  }

                  return  Expanded(
                    flex: 5,
                    child: ListView.separated(
                        itemCount: guestList.length,
                        itemBuilder: (context, index){
                          return _buildGuest(guestList[index], index);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        )
                    ),
                  );
                }

                return const CircularProgressIndicator();
              }),

          const SizedBox(height: 55,)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGuest()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );

  }

  List getGuests(snapshot){
    QuerySnapshot query = snapshot.data;
    return query.docs.map((e) => Guest.fromSnapshot(e as DocumentSnapshot<Map<String, dynamic>>)).toList();
  }

  Future addPhoneNumber(context, guest){
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Add phone number'),
          content: SingleChildScrollView(
            child: ListBody(
                children: <Widget>[
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,

                    decoration:  InputDecoration(
                      labelText: 'Phone Number',
                      suffixIcon: IconButton(     // Icon to
                          icon: const Icon(Icons.clear), // clear text
                          onPressed: (){_phoneNumberController.clear();}),
                    ),
                  ),


                ]
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _phoneNumberController.clear();
                });
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                  guest.phoneNumber = _phoneNumberController.text;
                  updateGuest(guest);
                  _phoneNumberController.clear();

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ));
  }


  Widget _buildGuest(Guest guest, int index){
    return Material(
      child: ListTile(
        key: ValueKey(guest),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: goldAccent, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        tileColor:  guest.isInvited ? green_ : Colors.transparent,
        title: Text(guest.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///if the guest is invited we display 'invited' otherwise a phone icon to call them
            ///if phone number is availble otherwise option to add phone number
            guest.isInvited ? const Text("Invited", style: TextStyle(fontStyle: FontStyle.italic),) :
            guest.phoneNumber!=null && guest.phoneNumber!.isNotEmpty ? //if phone number is available
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
                  addPhoneNumber(context, guest);
                },
                icon: const Icon(Icons.add_call)),
            PopupMenuButton(
              itemBuilder: (context) =>
              <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: (){
                    setState(() {
                      guest.isInvited = !guest.isInvited;
                    });
                    updateGuest(guest);

                  },
                    child: guest.isInvited ? const Text('Mark as not-invited', style: TextStyle(color: Colors.white),) : const Text('Mark as invited', style: TextStyle(color: Colors.white),)),
                PopupMenuItem(
                  onTap: (){
                    Navigator.pushNamed(
                        context,
                        '/addGuest',
                        arguments: guest
                    );
                  },
                    child: const Text('Edit', style: TextStyle(color: Colors.white),)),
                PopupMenuItem(

                  onTap: (){
                    confirmDelete(context, guest, "Guest");
                  },
                    child: const Text('Delete', style: TextStyle(color: Colors.white),)),
              ],
            ),
          ],
        ),

      ),
    );
  }


}