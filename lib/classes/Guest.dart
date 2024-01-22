class Guest{
  String _name;
  int _phoneNumber=0;
  bool _isInvited = false;

  Guest(this._name);

  Guest.withNumber(this._name, this._phoneNumber);

  bool get isInvited => _isInvited;

  set isInvited(bool value) {
    _isInvited = value;
  }

  int get phoneNumber => _phoneNumber;

  set phoneNumber(int value) {
    _phoneNumber = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

}


