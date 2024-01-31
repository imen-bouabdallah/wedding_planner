class ShopItem{
  String _name;
  int? _price;
  bool _bought = false;

  ShopItem(this._name, [this._price]);

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
}