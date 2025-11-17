
class ProductModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  final bool added;

  ProductModel({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.id,
    this.added = false,
  });
}

class Products {
  final List<ProductModel> products;
  Products({required this.products});
  factory Products.fromJson({required List<Map> json}) {
    final List<ProductModel> tempList = json.map<ProductModel>((product) {
      return ProductModel(
        name: product['name'],
        price: product['price'],
        description: product['description'],
        image: product['imagePath'],
        id: product['id'],
      );
    }).toList();
    return Products(products: tempList);
  }
}
