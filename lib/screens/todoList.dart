import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedding_planner/classes/ToDo_item.dart';


class Todo_list extends StatefulWidget {
  const Todo_list({super.key});

  @override
  State<Todo_list> createState() => _Todo_listState();
}

class _Todo_listState extends State<Todo_list> {
  @override
  final List<ToDo_item> items = [ToDo_item("first note", "you"), ToDo_item("something kind of short", "you")
  , ToDo_item("something long very long not too much", "someone"), ToDo_item("something", "others"),
    ToDo_item("a note that contains something", "you"), ToDo_item("something kind of short", "you")
    , ToDo_item("something long very long not too much that it can go on more that one ligne yest  jkdjdhsgjhgjhdfgjhdgfhdgfhgdjhfhdsgfjhqsgdhfgqs hdgfksjdhgfkqsgdkfhskqjfgsdhfhjfgsurp omlqksdlkqmùEI0ZIRMLQSKD.?S?.SCB N?WXBHJCHZIPLSF./S.D", "someone"), ToDo_item("something", "others")];




  FToast fToast = FToast();

  int completed = 0;

  late List<bool> _isSelected = List.generate(items.length, (i) => false);


  static final AppBar _defaultBar = AppBar(
    title: const Text('Tasks'),
    actions: [
      IconButton(
          onPressed: (){},
          icon: const Icon(Icons.more_vert))
    ],
  );

  AppBar _appBar = _defaultBar;

  AppBar _selectBar = AppBar();


  @override
  void initState() {
    // TODO: implement initState
    completed = 0;

    fToast.init(context);

    _selectBar = AppBar( //when a note is selected
      backgroundColor: Colors.deepPurpleAccent,
      leading: IconButton(onPressed: (){
        setState(() {
          _appBar = _defaultBar;
          _isSelected = List.generate(items.length, (i) => false); ///unselect all tiles
        });

      }, icon: const Icon(Icons.close)),
      title: const Text('number'),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
        IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
      ],
      automaticallyImplyLeading: false,
    );
  }


  Widget _buildToDo(ToDo_item item, int i){
    return ListTile(
      onLongPress: (){
        setState(() {
          _isSelected[i] = true;
          _appBar = _selectBar;
        });

      },
      tileColor: _isSelected[i] ? Colors.blue : null,
      leading: Checkbox(value: item.done,
        onChanged: (bool? value) {
          setState(() {
            item.done = value!;
            item.done ? completed++ : completed--;
            //push the done todos to the end of the list
            items.sort((a, b)=>
            (a == b ? 0 : (a.done ? 0 : -1))       );

            if(value) {
              fToast.showToast(
                toastDuration: const Duration(milliseconds: 1500),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.done),
                      Text(
                        " You've complete the task!  ",
                      )
                    ],
                  ),
                ),

                gravity: ToastGravity.BOTTOM,

              );
            }
          }
          );
        },
      ),
      subtitle:  Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.text,
                  softWrap: true  ,
                  style: item.done ?
                  const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black12) //strike the task
                      : const TextStyle(),
                ),
              ),
              Text(item.creator),
              IconButton(
                  onPressed: (){
                    setState(() {
                      item.starred = !item.starred;
                    });
                  },
                  icon: Icon(item.starred? Icons.star : Icons.star_border)),

            ],
          ),
          ///TODO if inserted create a space for due date
          /*const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding:  EdgeInsets.only(
                bottom: 10,
                top: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'due date + time',

                  ),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }

 /* Widget _buildToDo (ToDo_item item){
    return Row(
        children: [
          Checkbox(value: item.done,
              onChanged: (bool? value) {
                setState(() {
                  item.done = value!;
                  item.done ? completed++ : completed--;
                  //push the done todos to the end of the list
                  items.sort((a, b)=>
                    (a == b ? 0 : (a.done ? 0 : -1))       );

                  if(value) {
                    fToast.showToast(
                      toastDuration: const Duration(milliseconds: 1500),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.done),
                            Text(
                              " You've complete the task!  ",
                            )
                          ],
                        ),
                      ),

                      gravity: ToastGravity.BOTTOM,

                    );
                  }
                }
                );
              },
          ),
          Expanded(
            child: Text(
                item.text,
              softWrap: true  ,
              style: item.done ?
              const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black12) //strike the task
                  : const TextStyle(),
            ),
          ),
          const SizedBox(width: 10,),
          Text(item.creator),
          IconButton(
              onPressed: (){
                setState(() {
                  item.starred = !item.starred;
                });
          },
              icon: Icon(item.starred? Icons.star : Icons.star_border)),
        ],

    );
  }*/

  Future<void> _createTodo() async {
    return showDialog<void>(
      context: context,
      //T: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: TextFormField(
            //controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your todo'),
            autofocus: true,
            validator: (value){
              if(value == null || value.isEmpty) {
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
                Navigator.of(context).pop();
               // _addTodoItem(_textFieldController.text);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar,
      body: ListView(
        children: [
          const SizedBox(height:30,),
          for(int i=0; i<items.length; i++)
            !items[i].done ?
            _buildToDo(items[i], i) :
            const SizedBox(height: 0,),

          const Divider(indent: 10, endIndent: 10),

          ///if the task is done it's moved down the list
          Text('    Completed (${ completed.toString()})'),
          for(int i=0; i<items.length; i++)
            items[i].done ?
            _buildToDo(items[i], i) : const SizedBox(height: 0,),

          const SizedBox(height: 50),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=> _createTodo(),
        label: const Text('add task'),
        icon: const Icon(Icons.add),

        ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
