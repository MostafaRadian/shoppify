class CartItemModel {
  final int id;
  final String name;
  final String image;
  final double price;

  CartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });
}

class CartModel {
  final List<CartItemModel> cartItems;
  double totalPrice;

  CartModel({required this.cartItems, this.totalPrice = 0});

  factory CartModel.fromJson({required Map<String, dynamic> json}) {
    List<CartItemModel> tempList = json["products"].map<CartItemModel>((item) {
      return CartItemModel(
        id: item["id"],
        name: item["name"],
        image: item["imagePath"],
        price: item["price"],
      );
    }).toList();

    return CartModel(
      cartItems: tempList,
      totalPrice: json["totalPrice"].toDouble(),
    );
  }
}
