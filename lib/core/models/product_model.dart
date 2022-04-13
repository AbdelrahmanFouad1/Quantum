import 'package:moa/core/models/categories_model.dart';

class ProductModel {
  final int pId;
  final String title;
  final int price;
  final bool active;
  final int stock;
  final List<CategoriesModel>? categories;


  ProductModel({
    required this.pId,
    required this.title,
    required this.price,
    required this.active,
    required this.stock,
    required this.categories,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      pId:  json['id'] ?? 0,
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      active: json['active'] ?? false,
      stock: json['stock'] ?? 0,
      categories: json['categories'] != null ? List.from(json['categories']).map((e) => CategoriesModel.fromJson(e)).toList() : null,
    );
  }
}
