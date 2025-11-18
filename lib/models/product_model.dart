
class ProductModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;

  ProductModel({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.id,
  });
}

class Products {
  final List<ProductModel> products;
  Products({required this.products});
  factory Products.fromJson({required List json}) {
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
