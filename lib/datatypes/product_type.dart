/// This class represents a single product which its descriptions
class Product {
  final String product;
  final String description;
  final String productInformation;
  final String mainColour;

  Product(
      this.product, this.description, this.productInformation, this.mainColour);

  get getProduct => product;

  get getDescription => description;

  get getProductInformation => productInformation;

  get getMainColour => mainColour;
}
