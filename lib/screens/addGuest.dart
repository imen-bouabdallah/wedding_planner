import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedding_planner/classes/Guest.dart';

class AddGuest extends StatefulWidget {
  const AddGuest({super.key});

  @override
  State<AddGuest> createState() => _AddGuestState();
}

class _AddGuestState extends State<AddGuest> {
  final _guestNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _guestType = TextEditingController();
  final _menNumber = TextEditingController();
  final _womenNumber = TextEditingController();


  bool _validateName = false, _validateType = false;


  @override
  void dispose() {
    _womenNumber.dispose();
    _menNumber.dispose();
    _guestType.dispose();
    _phoneNumberController.dispose();
    _guestNameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var guest = null;
    if(ModalRoute.of(context)!.settings.arguments!=null) {
      guest = ModalRoute.of(context)!.settings.arguments as Guest; //get the passed data

      _guestNameController.text = guest.name;
      _guestType.text = guest.type;
      _menNumber.text = guest.menNumber.toString();
      _womenNumber.text = guest.womenNumber.toString();
      if (guest.phoneNumber !=null) {
        _phoneNumberController.text = guest.phoneNumber!;
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: guest==null ? const Text("Add Guest") : const Text("Edit Guest"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,

            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              TextField(
                textCapitalization: TextCapitalization.words,
                 controller: _guestNameController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Guest Name',
                  errorText: _validateName ? "Value Can't Be Empty" : null,
                ),

              ),
              const SizedBox(height: 10,),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number (optional)',
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
                    initialSelection: _guestType,
                    requestFocusOnTap: false, //so that we have to choose from menu
                    errorText: _validateType ? "Please select category" : null,
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
                    FilledButton(onPressed: () {
                      setState(() {
                        _validateName = _guestNameController.text.isEmpty;
                        _validateType = _guestType.text.isEmpty;
                      });

                      if(!_validateName && !_validateType){
                        if(_womenNumber.text.isEmpty) _womenNumber.text = '0';
                        if(_menNumber.text.isEmpty) _menNumber.text = '1';

                        ///see if we need to save a new one or edit an existing
                        var db = FirebaseFirestore.instance.collection("Guest");
                        var newGuest = Guest(_guestNameController.text, _guestType.text, _phoneNumberController.text, int.parse(_womenNumber.text), int.parse(_menNumber.text));

                        if(guest==null){ //save
                          //create a new one
                          db.add(newGuest.toJson()).whenComplete(
                                  (){
                                Fluttertoast.showToast(msg: "new guest saved successfully");
                                Navigator.pop(context);
                              }
                          ).catchError((error, stackTrace){
                            Fluttertoast.showToast(msg: "Error, something went wrong please try again");
                          });
                        }
                        else { //edit
                          db
                              .doc(guest.id)
                              .update({
                            'name' : newGuest.name,
                            "phoneNumber" : newGuest.phoneNumber,
                            "type" : newGuest.type,
                            "menNumber" : newGuest.menNumber,
                            "womenNumber" : newGuest.womenNumber,
                          })
                              .then((_) { Fluttertoast.showToast(msg: "Edited successfully");
                                Navigator.pop(context);})
                              .catchError((error) => Fluttertoast.showToast(msg: "Error, something went wrong please try again"));
                        }




                      }

                    }, child: const Text('Save')),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
