import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedding_planner/classes/Helpers.dart';
import 'package:wedding_planner/classes/ShopItem.dart';
import 'package:wedding_planner/style/Theme.dart';


class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  List shopList = [];

  final _itemController = TextEditingController();
  final _priceController = TextEditingController();

  var db = FirebaseFirestore.instance.collection('ShopItems');
  late Stream<QuerySnapshot> _stream;

  int _spending=0, _total=0;

  bool _validateItem = false;

  Widget _shopItem(ShopItem item, int index){
    return ListTile(
      title: Text(item.name, style: const TextStyle(fontSize: 20),),
      subtitle: Row(
        children: [
          const SizedBox(width: 30,),
          (item.price!=null) ? Text('Price : ${item.price.toString()}') : const SizedBox(),
        ],
      ),
      trailing: Checkbox(
        onChanged: (bool? value){
          setState(() {
            item.bought = value!;
            _calculateSpending();
          });
          db.doc(item.id).update({"bought" : item.bought}).then((_) {
            if(value!)  Fluttertoast.showToast(msg: "Item purchased!");
          })
              .catchError((error) => Fluttertoast.showToast(msg: "Error, something went wrong please try again"));;

        },
        value: item.bought,

      ),



      /*
      PopupMenuButton(
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
                  onPressed: (){/*confirmDelete(context, item);*/            },
                  child: const Text('Delete'))),
        ],
      ),*/
    );
  }

  Future<void> _createItem() async {
    return showDialog<void>(
      context: context,
      //T: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState)
        {
          return AlertDialog(
            title: const Text('Add a todo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _itemController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: 'Purchased item',
                    errorText: _validateItem ? "Value Can't Be Empty" : null,),
                  autofocus: true,
                ),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(hintText: 'Price (optional)'),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            actions: <Widget>[
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  _priceController.clear();
                  _itemController.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () async {
                  setState(() {
                    _validateItem = _itemController.text.isEmpty;
                  });
                  if (!_validateItem) {

                    if (_priceController.text.isNotEmpty) {
                      ShopItem item = ShopItem(_itemController.text, int.parse(_priceController.text));
                      await createShopItem(item, context);

                    } else {

                      ShopItem item = ShopItem(_itemController.text, 0);
                      //add it to db
                      await createShopItem(item, context);
                    }

                    _priceController.clear();
                    _itemController.clear();
                    _calculateTotal();
                  }
                },
              ),
            ],
          );
        }
        );
      },
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
    _total=0;
      for (var element in shopList) {
        int a;
        if (element.price!=null) {
          a = element.price;
        } else {
          a = 0;
        }

        _total += a;}

  }

  @override
  void initState() {
    _calculateSpending();
    _calculateTotal();

    _stream = db.snapshots();
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
          StreamBuilder(
              stream: _stream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  if(snapshot.connectionState == ConnectionState.active){
                    shopList = getList(snapshot);

                    return Expanded(
                      flex: 1,
                      child: Scrollbar(
                        child: ListView.builder(
                            itemCount: shopList.length,
                            itemBuilder: (context, index){
                              return _shopItem(shopList[index], index);
                            }),
                      ),
                    );
                  }

                }
                else if(snapshot.hasError){
                  return Center(child: Text("Error ${snapshot.error}"),);
                }
                else{
                  return const CircularProgressIndicator();
                }
                return const SizedBox();
              },),
          const SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StreamBuilder(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData){
                  if(snapshot.connectionState == ConnectionState.active){
                    _calculateSpending();
                    _calculateTotal();
                    return Row(
                      children: [
                        const SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2,  color: gold.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                  colors: [gold.withOpacity(0.4), dun.withOpacity(0.6)]
                              )
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Text('Money spent :  $_spending',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: gold.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                  colors: [gold.withOpacity(0.4), dun.withOpacity(0.6)]
                              )
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Text('Aproximate total : $_total',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                      ],
                    );
                  }
                }
                else if(snapshot.hasError){
                  print(snapshot.error.toString());
                }
                return CircularProgressIndicator();
              },

            ),
          ),
          const SizedBox(height: 100,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_createItem();},
        child:  const Icon(Icons.add),
      ),
    );
  }

  getList(snapshot){
    QuerySnapshot query = snapshot.data;
    return query.docs.map((e) => ShopItem.fromSnapshot(e as DocumentSnapshot<Map<String, dynamic>>)).toList();


  }
}
