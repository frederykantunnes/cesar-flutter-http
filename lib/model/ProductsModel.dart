import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hmais_argamassa/config/StringsConfig.dart';

class ProductsModel{
  final int id;
  final String name;
  final String description;
  final String picture;
  final String care;
  final List sizes;
  final List colors;

  ProductsModel({this.id, this.name, this.description, this.picture, this.care, this.sizes, this.colors});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        picture: json['picture'],
        care: json['care'],
        sizes: json['sizes'],
        colors: json['colors']
    );
  }


  Future<List<ProductsModel>> getData() async {
    final response = await http.get(StringsConfig().urlApi+StringsConfig().ep_produtos);
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<ProductsModel> dados = null;
      dados = l.map((i)=> ProductsModel.fromJson(i)).toList();
      return dados;
    } else {
      throw Exception('Failed to load data');
    }
  }

}