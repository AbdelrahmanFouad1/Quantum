
class MainCartModel {
  final List<CartModel> data;

  MainCartModel({
    required this.data,
  });

  factory MainCartModel.fromJson(Map<String, dynamic> json) {
    return MainCartModel(
      data: List.from((json['data'] as List))
          .map((e) => CartModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CartModel {

  final int pId;
  final String title;
  final int price;
  final bool active;
  final int stock;
  late int quantity;

  CartModel({
    required this.pId,
    required this.title,
    required this.price,
    required this.active,
    required this.stock,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      pId:  json['id'] ,
      title: json['title'] ,
      quantity: json['quantity'],
      price: json['price'] ,
      active: json['active'] ,
      stock: json['stock'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': pId,
      'title': title,
      'price': price,
      'active': active,
      'stock': stock,
      'quantity': quantity,
    };
  }
}
