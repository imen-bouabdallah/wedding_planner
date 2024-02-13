import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding_planner/classes/Helpers.dart';
import 'package:wedding_planner/classes/Guest.dart';
import 'package:wedding_planner/screens/pages/detailedGuestList.dart';
import 'package:wedding_planner/style/Theme.dart';
import 'package:wedding_planner/screens/addGuest.dart';

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


  @override
  void initState() {
     super.initState();
     _streamGuestList = _refGuestList.snapshots();

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
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const DetailedList()),
                );
              },

              icon: const Icon(Icons.info_outline) ),
        ],
      ),


      body: Column(
        children: [
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              PopupMenuButton(
                //icon: const Icon(Icons.email),
                  child: Row(
                    children: [
                      Text('Send an invitation', style: TextStyle(color: gold, fontSize: 20),),
                      const SizedBox(width: 4,),
                      Icon(Icons.email, color: gold,),
                      const SizedBox(width: 10,),
                    ],
                  ),

                  //choose picture
                  itemBuilder: (context)=> <PopupMenuEntry>[

                    PopupMenuItem(
                        child: TextButton(
                            onPressed: (){Navigator.pop(context); _onShareXFileFromAssets(context, 'invite/invitation_ar.png');},
                            child: const Text('Arabic Invitation'))),
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: (){Navigator.pop(context); _onShareXFileFromAssets(context, 'invite/invitation_fr.png');},
                            child: const Text('French invitation'))),
                  ],

              ),
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
                  guestList.sort((a, b) {
                    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                  });
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

  Future addPhoneNumber(context){
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
                setState(() {
                  //guest_list[index].phoneNumber = _phoneNumberController.text.toString();
                  _phoneNumberController.clear();
                });
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

  void _onShareXFileFromAssets(BuildContext context, String file) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final data = await rootBundle.load('assets/$file');
    final buffer = data.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: file,
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
           const Text("Invitation is shared!")
          else
            const Text("Failed to share")
        ],
      ),
    );
  }
}