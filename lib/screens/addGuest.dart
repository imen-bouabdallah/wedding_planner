import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Guest"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,

            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
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
      ),
    );
  }
}
