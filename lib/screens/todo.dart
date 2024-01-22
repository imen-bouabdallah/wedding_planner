import 'package:flutter/material.dart';

class Todo_list extends StatefulWidget {
  const Todo_list({super.key});

  @override
  State<Todo_list> createState() => _Todo_listState();
}

class _Todo_listState extends State<Todo_list> {
  @override

  Container note (){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),

      ),
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (bool? value){})
        ],
      ),
    );
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
      body: const Column(

      ),
    );
  }
}
