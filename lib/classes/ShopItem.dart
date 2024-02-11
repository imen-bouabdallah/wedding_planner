import 'package:cloud_firestore/cloud_firestore.dart';

class ShopItem{
  String _id;
  String _name;
  int? _price;
  bool _bought ;

  ShopItem(this._name, [this._price, this._bought = false, this._id='']);

  int? get price => _price;

  set price(int? value) {
    _price = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get bought => _bought;

  set bought(bool value) {
    _bought = value;
  }


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  toJson(){
    return {
      "name" : _name,
      "price" : _price,
      "bought" : _bought,
    };
  }


  factory ShopItem.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return ShopItem(
      data["name"],
      data["price"],
      data["bought"],
      document.id,
    );
  }
}