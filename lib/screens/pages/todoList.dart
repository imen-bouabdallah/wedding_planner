import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedding_planner/classes/Helpers.dart';
import 'package:wedding_planner/classes/ToDo_item.dart';

class Todo_list extends StatefulWidget {
  const Todo_list({super.key});

  @override
  State<Todo_list> createState() => _Todo_listState();
}

class _Todo_listState extends State<Todo_list> {
  List selectedItems = [];  List _completedItems = [];  List _items = [];

  final _taskController = TextEditingController();

  FToast fToast = FToast();

  int completed = 0;
  var db = FirebaseFirestore.instance.collection('Tasks');
  late Stream<QuerySnapshot> _stream, _streamComplete;

  late List<bool> _isSelected = List.generate(selectedItems.length, (i) => false);

  static final AppBar _defaultBar = AppBar(
    title: const Text('Tasks'),
    actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
  );

  AppBar _appBar = _defaultBar;

  AppBar _selectBar = AppBar();


  Widget _buildToDo(ToDo_item item, int i){
    //build the tiles
    return ListTile(
      onLongPress:  () {
        setState(() {
          _isSelected[i] = true;
          _appBar = _selectBar;
          selectedItems.add(item);
        });
      } ,
      leading: Checkbox(
        value: item.done,
        onChanged: (bool? value) {
          setState(() {
            item.done = value!;

            //updateData in firestore
            db
                .doc(item.id)
                .update({"done":item.done}).then((_) {
                  if(value)  Fluttertoast.showToast(msg: "You've complete the task!");
                  })
        .catchError((error) => Fluttertoast.showToast(msg: "Error, something went wrong please try again"));

          });
        },
      ),
      title: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.text,
                  softWrap: true,
                  style: item.done
                      ? const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black12) //strike the task
                      : const TextStyle(),
                ),
              ),
              /*item.private ? Text( '${convertUserName(item.id)} ',
                style: TextStyle(fontStyle: FontStyle.italic),)
                  : Text(''),*/
            ],
          ),
        ],
      ),


      /*IconButton(
          onPressed: () {
            item.done? null :
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Change privacy'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                            item.private? 'Change the privacy to Public?'
                                : 'Change the privacy to Private?'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                    FilledButton(
                      onPressed: () async {

                        await db.doc(item.id).update({"private" : !item.private}).then(
                                (value) {
                              setState(() {
                                item.private = !item.private;
                              });
                            }).onError((error, stackTrace) {
                          Fluttertoast.showToast(msg: "only owner can change privacy of this item");
                        });

                        Navigator.pop(context);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ));
          },
          icon: Icon(
              !item.private ? Icons.lock_open_rounded : Icons.lock)),*/
    );
  }

  Future<void> _createTodo() async {
    return showDialog<void>(
      context: context,
      //T: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: TextFormField(
            controller: _taskController,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(hintText: 'Type your todo'),
            autofocus: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a text';
              }
              return null;
            },
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                _taskController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {

                var item = ToDo_item(_taskController.text,FirebaseAuth.instance.currentUser!.uid.toString(), false);
                  createTask(item);
                  _taskController.clear();

                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }




  @override
  void initState() {
    super.initState();

    _stream = db.where("done", isEqualTo: false).snapshots();
    _streamComplete = db.where("done", isEqualTo: true).snapshots();

    fToast.init(context);

    _selectBar = AppBar(
      //when a note is selected change app bar
      backgroundColor: Colors.deepPurpleAccent,
      leading: IconButton(
          onPressed: () {
            setState(() {
              _appBar = _defaultBar;
              _isSelected = List.generate(selectedItems.length, (i) => false);

              ///unselect all tiles
            });
          },
          icon: const Icon(Icons.close)),
      title: const Text('number'),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child:Column(
          mainAxisSize: MainAxisSize.max,
          children: [
          const SizedBox(
          height: 30,
        ),

        StreamBuilder< QuerySnapshot>(
          stream:_stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData){
              if(snapshot.connectionState == ConnectionState.active){
                QuerySnapshot query = snapshot.data;
                _items = query.docs.map((e) =>
                    ToDo_item.fromSnapshot(e as DocumentSnapshot<Map<String, dynamic>>))
                    .toList();

                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),//to make it scroll with the column instead of by itself
                      shrinkWrap: true,
                      itemCount: _items.length,
                      itemBuilder: (context, index){
                        return _buildToDo(_items[index], index);
                      });
              }
            }
            else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            else {
              return const CircularProgressIndicator();
            }
            return const SizedBox();
          },

        ),


            const Divider(indent: 10, endIndent: 10),

            ///if the task is done it's moved down the list
          StreamBuilder(
              stream: _streamComplete,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData){
                  if(snapshot.connectionState == ConnectionState.active){
                    return Row(
                      children: [
                        Text('   Completed (${snapshot.data?.size})'),
                      ],
                    );
                  }
                }else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                else {
                  return const CircularProgressIndicator();
                }

                return const Row(
                  children: [
                    Text('   Completed (0)'),
                  ],
                );
              }
          ),

            StreamBuilder(
              stream: _streamComplete,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)  {
                if(snapshot.hasData){
                  if(snapshot.connectionState == ConnectionState.active){

                    _completedItems = snapshot.data.docs.map((e) =>
                        ToDo_item.fromSnapshot(e as DocumentSnapshot<Map<String, dynamic>>))
                        .toList();

                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _completedItems.length,
                        itemBuilder: (context, index){
                          return _buildToDo(_completedItems[index], index);
                        });

                  }
                }
                else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                else {
                  return const CircularProgressIndicator();
                }
                return const SizedBox();
              },

            ),


            const SizedBox(height: 50),
          ]
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createTodo(),
        label: const Text('add task'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


