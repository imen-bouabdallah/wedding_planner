class Guest{
  String _name;
  String? _phoneNumber= '';
  bool _isInvited = false;

  Guest(this._name, [this._phoneNumber]);



  bool get isInvited => _isInvited;

  set isInvited(bool value) {
    _isInvited = value;
  }

  String? get phoneNumber => _phoneNumber;

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }


}


