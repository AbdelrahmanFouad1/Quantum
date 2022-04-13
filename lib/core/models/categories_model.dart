import 'package:moa/core/models/product_model.dart';

class CategoriesModel {
  final int cId;
  final String title;
  final List<ProductModel>? products;


  CategoriesModel({
    required this.cId,
    required this.title,
    required this.products,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      cId:  json['id'] ?? 0,
      title: json['title'] ?? '',
      products:json['products'] != null ? List.from(json['products']).map((e) => ProductModel.fromJson(e)).toList() : null,
    );
  }
}
