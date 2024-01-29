import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding_planner/classes/Guest.dart';
import 'package:wedding_planner/classes/Theme.dart';

class Guest_list extends StatefulWidget {
  const Guest_list({Key? key}) : super(key: key);

  @override
  State<Guest_list> createState() => _Guest_listState();
}

class _Guest_listState extends State<Guest_list> {
  @override

  final _guestNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _guestType = TextEditingController();
  final _menNumber = TextEditingController();
  final _womenNumber = TextEditingController();




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
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: goldAccent, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      tileColor:  guest.isInvited ? Colors.green : Colors.transparent,
      subtitle: Row(
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

  Widget _createGuest(){
    return  Dialog.fullscreen(

      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,

          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            const Row(
              children: [
                SizedBox(width: 5,),
                 Text('Add Guest ',
                style: TextStyle(
                  fontSize: 20
                ),),
              ],
            ),
            const Divider(),
            const SizedBox(height: 60,),
            TextFormField(
              controller: _guestNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Guest Name',
                  fillColor: Colors.blue
              ),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Please enter the name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                  labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Expanded(
                    child: TextField(
                      controller: _menNumber,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Men count',
                      ),
                    ) ),
                const SizedBox(width: 10,),
                Expanded(
                    child: TextField(
                      controller: _womenNumber,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Women count',
                      ),
                      onTapOutside: (event) {
                        print('onTapOutside');
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                )
              ],
            ),
            const SizedBox(height: 15,),

            Row(
              children: [
                DropdownMenu(
                  onSelected: (value){


                  },
                  label: const Text('Category'),
                  controller: _guestType,
                  initialSelection: 'Family',
                  requestFocusOnTap: false, //so that we have to choose from menu

                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'Family', label: 'Family'),
                    DropdownMenuEntry(value: 'Friends', label: 'Friends'),
                    DropdownMenuEntry(value: 'Neighbors', label: 'Neighbors'),
                    DropdownMenuEntry(value: 'Others', label: 'Others'),],

                ),
              ],
            ),

            const SizedBox(height: 50,),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text('Cancel')),
                  const SizedBox(width: 10,),
                  FilledButton(onPressed: (){}, child: const Text('Save')),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


  @override
  void dispose() {


    _guestNameController.dispose();
    _phoneNumberController.dispose();
    _guestType.dispose();
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


      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),//to make it scroll with the column instead of by itself
                shrinkWrap: true,
              itemCount: guest_list.length,
                itemBuilder: (context, index){
                 return _buildGuest(guest_list[index], index);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                )
            ),
            const SizedBox(height: 60,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(context: context,
        builder: (BuildContext context)=> _createGuest()),
        child: const Icon(Icons.add),
      ),
    );

  }
}