import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hmais_argamassa/config/StringsConfig.dart';
import 'package:hmais_argamassa/controller/UserController.dart';

class RewardsModel{
  final int id;
  final String name;
  final String description;
  final String picture;
  final String points;

  static RewardsModel rewardsModelSelected;

  RewardsModel({this.id, this.name, this.description, this.picture, this.points});

  factory RewardsModel.fromJson(Map<String, dynamic> json) {
    return RewardsModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        picture: json['picture'],
        points: json['points']
    );
  }


  Future<List<RewardsModel>> getData() async {
    final response = await http.get(StringsConfig().urlApi+StringsConfig().ep_beneficios+"/"+UserController.usuarioLogado.id.toString());
    if (response.statusCode == 200) {
      UserController.pointsUsuarioLogado = json.decode(response.body)[0]["points"];
      Iterable l = json.decode(response.body)[0]["beneficios"];
      List<RewardsModel> dados = null;
      dados = l.map((i)=> RewardsModel.fromJson(i)).toList();
      return dados;
    } else {
      throw Exception('Failed to load data');
    }
  }

}