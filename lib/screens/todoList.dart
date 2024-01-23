import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/ToDo_item.dart';


class Todo_list extends StatefulWidget {
  const Todo_list({super.key});

  @override
  State<Todo_list> createState() => _Todo_listState();
}

class _Todo_listState extends State<Todo_list> {
  @override

  int completed = 0;
  List<ToDo_item> items = [ToDo_item("first note", "you"), ToDo_item("something kind of short", "you")
  , ToDo_item("something long very long not too much", "someone"), ToDo_item("something", "others"),
    ToDo_item("a note that contains something", "you"), ToDo_item("something kind of short", "you")
    , ToDo_item("something long very long not too much that it can go on more that one ligne yest  jkdjdhsgjhgjhdfgjhdgfhdgfhgdjhfhdsgfjhqsgdhfgqs hdgfksjdhgfkqsgdkfhskqjfgsdhfhjfgsurp omlqksdlkqmùEI0ZIRMLQSKD.?S?.SCB N?WXBHJCHZIPLSF./S.D", "someone"), ToDo_item("something", "others")];

  Row note (ToDo_item item){
    return Row(
        children: [
          Checkbox(value: item.done,
              onChanged: (bool? value) {
                setState(() {
                  item.done = value!;
                  item.done ? completed++ : completed--;
                  //push the done todos to the end of the list
                  items.sort((a, b)=>
                    (a == b ? 0 : (a.done ? 0 : -1))

                    /*{ //sort the list according to done
                    if (b.done) return 1; //if it's done push it to the top (for now)
                    // else
                    return 0; // if it's unchecked
                  }*/
                  );

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
  }

  @override
  void initState() {
    // TODO: implement initState
    completed = 0;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height:30,),
          for(int i=0; i<items.length; i++)
            !items[i].done ?
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                 /* decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),*/
                  child: note(items[i]),
                ),
                const SizedBox(height: 10,),
              ],
            ) :
            const SizedBox(height: 0,),


          const Divider(indent: 10, endIndent: 10),

          ///if the task is done it's moved down the list
          Text('Completed (${ completed.toString()})'),
          for(int i=0; i<items.length; i++)
            items[i].done ?
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  /* decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),*/
                  child: note(items[i]),
                ),
                const SizedBox(height: 10,),
              ],
            ) : const SizedBox(height: 0,),

          const SizedBox(height: 50),

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>{},
        label: const Text('add task'),
        icon: const Icon(Icons.add),

        ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
