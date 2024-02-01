import 'package:flutter/material.dart';
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
  var guest = null;

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
    if(ModalRoute.of(context)!.settings.arguments!=null)
      guest = ModalRoute.of(context)!.settings.arguments as Guest; //get the passed data
    if (guest.toString().isNotEmpty && guest != null){
      _guestNameController.text = guest.name;
      _guestType.text = guest.type;
      _menNumber.text = guest.menNumber.toString();
      _womenNumber.text = guest.womenNumber.toString();
      if (guest.phoneNumber !=null)
        _phoneNumberController.text = guest.phoneNumber!;
    }


    return Scaffold(
      appBar: AppBar(
        title: guest.toString().isEmpty? const Text("Add Guest") : const Text("Edit Guest"),
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

                 controller: _guestNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
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
                    FilledButton(onPressed: (){
                      setState(() {
                        _validateName = _guestNameController.text.isEmpty;
                        _validateType = _guestType.text.isEmpty;
                      });

                      if(!_validateName && !_validateType){
                        print('save guest');
                        //if mencount not empty add it
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
