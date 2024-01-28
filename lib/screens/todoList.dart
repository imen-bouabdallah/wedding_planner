import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedding_planner/classes/ToDo_item.dart';

class Todo_list extends StatefulWidget {
  const Todo_list({super.key});

  @override
  State<Todo_list> createState() => _Todo_listState();
}

class _Todo_listState extends State<Todo_list> {
  final List<ToDo_item> items = [
    ToDo_item("first note"),
    ToDo_item("something kind of short"),
    ToDo_item("something long very long not too much"),
    ToDo_item("something"),
    ToDo_item("a note that contains something"),
    ToDo_item("something kind of short"),
    ToDo_item("something kind of short"),
    ToDo_item("something long very long not too much"),
    ToDo_item("something"),
    ToDo_item("a note that contains something"),
    ToDo_item("something kind of short"),
    ToDo_item("something kind of short"),
    ToDo_item("something long very long not too much"),
    ToDo_item("something"),
    ToDo_item("a note that contains something"),
    ToDo_item("something kind of short"),
    ToDo_item(
        "something long very long not too much that it can go on more that one ligne yest  "),
    ToDo_item("something")
  ];
  late List<ToDo_item> _completedItems;
  late List<ToDo_item> _items;

  final _taskController = TextEditingController();

  FToast fToast = FToast();

  int completed = 0;

  late List<bool> _isSelected = List.generate(items.length, (i) => false);

  static final AppBar _defaultBar = AppBar(
    title: const Text('Tasks'),
    actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
  );

  AppBar _appBar = _defaultBar;

  AppBar _selectBar = AppBar();

  @override
  void initState() {

    _completedItems = items.where((e) => e.done == true).toList();
    completed = _completedItems.length;

    _items = items.where((e) => e.done == false).toList();


    fToast.init(context);

    _selectBar = AppBar(
      //when a note is selected change app bar
      backgroundColor: Colors.deepPurpleAccent,
      leading: IconButton(
          onPressed: () {
            setState(() {
              _appBar = _defaultBar;
              _isSelected = List.generate(items.length, (i) => false);

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

  Widget _buildToDo(ToDo_item item, int i) {
    //build the tiles
    return ListTile(
      onLongPress: () {
        setState(() {
          _isSelected[i] = true;
          _appBar = _selectBar;
        });
      },
      tileColor: _isSelected[i] ? Colors.blue : null,
      leading: Checkbox(
        value: item.done,
        onChanged: (bool? value) {
          setState(() {
            item.done = value!;
            item.done ? completed++ : completed--;

            if(item.done) //remove the item from one list and add it to another
            {_completedItems.add(item); _items.remove(item);}
            else {_completedItems.remove(item); _items.add(item);}
            //push the done todos to the end of the list
            //items.sort((a, b) => (a == b ? 0 : (a.done ? 0 : -1)));

            if (value) {
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
          });
        },
      ),
      subtitle: Column(
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
              IconButton(
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
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      item.private = !item.private;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ));
                  },
                  icon: Icon(
                      !item.private ? Icons.lock_open_rounded : Icons.lock)),
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

  Future<void> _createTodo() async {
    return showDialog<void>(
      context: context,
      //T: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: TextFormField(
            controller: _taskController,
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
                // Navigator.of(context).pop();
                // _addTodoItem(_textFieldController.text);
                setState(() {
                  items.add(ToDo_item(_taskController.text));
                });
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  _updateTodoList(){
    setState(() {
      items.length;
    });
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 30,
            ),

            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),//to make it scroll with the column instead of by itself
              shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, index){
                  return _buildToDo(_items[index], index);
                }),
            const Divider(indent: 10, endIndent: 10),

            ///if the task is done it's moved down the list
            Row(
              children: [
                Text('   Completed (${completed.toString()})'),
              ],
            ),

            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _completedItems.length,
                itemBuilder: (context, index){
                  return _buildToDo(_completedItems[index], index);
                }),
            const SizedBox(height: 50),
          ],
        ),
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
