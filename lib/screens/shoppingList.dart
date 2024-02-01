import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Functions.dart';
import 'package:wedding_planner/classes/ShopItem.dart';


class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  List shopList = [ShopItem("batata"), ShopItem("bsal", 500)];

  int _spending=0, _total=0;

  Widget _shopItem(ShopItem item, int index){
    return ListTile(
      leading: Checkbox(
        onChanged: (bool? value){
          setState(() {
            item.bought = value!;
            _calculateSpending();
          });
          },
        value: item.bought,),
      title: Text(item.name, style: const TextStyle(fontSize: 20),),
      subtitle: Row(
        children: [
          const SizedBox(width: 30,),
          const Text('Price : '),
          (item.price!=null) ? Text(item.price.toString()) : const SizedBox(),
        ],
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context)=> <PopupMenuEntry>[
          PopupMenuItem(
              child: TextButton(
                  onPressed: (){
                    Navigator.pop(context);//close the popup menu
                    ///TODO dialog
                  },
                  child: const Text('Edit'))),
          PopupMenuItem(
              child: TextButton(
                  onPressed: (){confirmDelete(context);            },
                  child: const Text('Delete'))),
        ],
      ),
    );
  }

  _calculateSpending(){
    _spending=0;
    for (var element in shopList) {
      int a;
      if (element.bought && element.price!=null) {
        a = element.price;
      } else {
        a = 0;
      }

      _spending +=a;}

  }
  _calculateTotal(){
    setState(() {
      for (var element in shopList) {
        int a;
        if (element.price!=null) {
          a = element.price;
        } else {
          a = 0;
        }

        _total += a;}
    });
  }

  @override
  void initState() {
    _calculateSpending();
    _calculateTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40,),
          Expanded(
            flex: 1,
              child: ListView.builder(
                itemCount: shopList.length,
                  itemBuilder: (context, index){
                  return _shopItem(shopList[index], index);
                  })),
          const SizedBox(height: 10,),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                     Text('Spent \n $_spending',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

                  ],
                ),
              ),
              const VerticalDivider(thickness: 5, color: Colors.black,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text('Total \n $_total',
                      textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 100,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child:  const Icon(Icons.add),
      ),
    );
  }
}
