import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding_planner/classes/Guest.dart';
import 'package:wedding_planner/style/Theme.dart';
import 'package:wedding_planner/screens/addGuest.dart';

class Guest_list extends StatefulWidget {
  const Guest_list({Key? key}) : super(key: key);

  @override
  State<Guest_list> createState() => _Guest_listState();
}

class _Guest_listState extends State<Guest_list> {
  @override
  final _phoneNumberController = TextEditingController();

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

  Widget _buildGuest(Guest guest, int index){
    return Material(
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: goldAccent, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        tileColor:  guest.isInvited ? green_ : Colors.transparent,
        subtitle: Text(guest.name),
        trailing: guest.phoneNumber.isNotEmpty ? //if phone number is available
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
                  showDialog<String>(
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
                                guest_list[index].phoneNumber = _phoneNumberController.text.toString();
                                _phoneNumberController.clear();
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ));
                },
                icon: const Icon(Icons.add_call)),
      
      ),
    );
  }

  @override
  void initState() {
    _phoneNumberController.text='';
    super.initState();
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
              onPressed: (){},

              icon: const Icon(Icons.more_vert) ),
        ],
      ),


      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(

              style: ButtonStyle(foregroundColor: MaterialStateProperty.all(gold),),
              onPressed: (){
                  //choose picture
                 <PopupMenuEntry>[
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: (){

                          },
                          child: const Text('Edit'))),
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: (){ },
                          child: const Text('Delete'))),
                ];
                  //_onShareXFileFromAssets(context, 'invite/invitation_fr.png');
                },
                child : const Row(
                  children: [
                    Text('Send an invitation'),
                    SizedBox(width: 4,),
                    Icon( Icons.email),
                  ],
                ),
                ),
              const SizedBox(width: 20,)
            ],
          ),
          Expanded(
            flex: 1,
            child: ListView.separated(
              itemCount: guest_list.length,
                itemBuilder: (context, index){
                 return _buildGuest(guest_list[index], index);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                )
            ),
          ),
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