class Guest{
  String _name;
  String? _phoneNumber= '';
  bool _isInvited = false;
  String _type;
  int _menNumber ;
  int _womenNumber ;

  Guest([this._name ="", this._type ='', this._phoneNumber, this._womenNumber = 0, this._menNumber = 1]);


  int get menNumber => _menNumber;

  set menNumber(int value) {
    _menNumber = value!;
  }

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

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  int get womenNumber => _womenNumber;

  set womenNumber(int value) {
    _womenNumber = value!;
  }

  toJson(){
    return {
      "name" : _name,
      "phoneNumber" : _phoneNumber,
      "type" : _type,
      "isInvited" : _isInvited,
      "menNumber" : _menNumber,
      "womenNumber" : _womenNumber,
    };
  }
}


