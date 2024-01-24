class User{
  String _identifier;

  String get identifier => _identifier;

  set identifier(String value) {
    _identifier = value;
  }

  User(this._identifier);
}