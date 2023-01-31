/// This class represents a single product which its descriptions
class Product {
  final String _product;
  final String _description;
  final String _mainColour;

  Product(this._product, this._description, this._mainColour);

  get getProduct => _product;

  get getDescription => _description;

  get getMainColour => int.parse(_mainColour);
}
