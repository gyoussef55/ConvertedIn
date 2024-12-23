/// The product is represented as a dictionary with the following keys:
/// - [id]: The product id.
/// - [quantity]: The quantity of the product.
/// - [name]: The name of the product.
/// In IOS, id and quantity are Integers, and name is a String.
/// In Android, id, quantity and name are Strings.
class ConvertedInProduct {
  final int id;
  final int quantity;
  final String? name;
  ConvertedInProduct({required this.id, required this.quantity, this.name});
  static Map<String, String> toMap(ConvertedInProduct product) {
    return {
      'id': product.id.toString(),
      'quantity': product.quantity.toString(),
      'name': product.name ?? '',
    };
  }
}