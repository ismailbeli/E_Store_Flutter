class Product {
  int? _id; // Make _id nullable
  late String _name;
  late String _description;
  late double _price;

  Product(this._name, this._description, this._price); // Constructor
  Product.withId(this._id, this._name, this._description, this._price); // Constructor for updating the product

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    if (value.length >= 2) {
      _name = value;
    }
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  // Convert a Product object into a Map object for storing in the database
  Map<String, dynamic> createMap() {
    var map = <String, dynamic>{}; // Map object
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    return map;
  }

  // Extract a Product object from a Map object
  Product.fromObject(dynamic o) {
    _id = o['Id'];
    _name = o['Name'] ?? 'Unknown';
    _description = o['Description'] ?? 'No description';
    _price = double.tryParse(o['Price'].toString()) ?? 0.0;
  }
}