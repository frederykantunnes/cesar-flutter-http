import 'package:crypto/crypto.dart';
import 'package:hmais_argamassa/config/DatabaseHelper.dart';
import 'package:hmais_argamassa/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:hmais_argamassa/view/DialogAlert.dart';
import 'package:hmais_argamassa/config/StringsConfig.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hmais_argamassa/view/home.dart';

class UserController{
  static UserModel usuarioLogado;
  static int pointsUsuarioLogado;
  final dbHelper = DatabaseHelper.instance;

  final textControllerCnpj = TextEditingController();
  final textControllerSenha = TextEditingController();

  Future<UserModel> validarUsuario(BuildContext context) async {
    String cnpj_text = textControllerCnpj.text.toString();
    String senha_text = textControllerSenha.text.toString();
    if (cnpj_text.isEmpty || senha_text.isEmpty){
      DialogAlert().showMessageDialog(context, "Login", "CNPJ e/ou Senha em Branco!");
    }else{
      DialogAlert().showProgressDialog(context, "Validando Informacões...");
      String cnpj = cnpj_text.replaceAll(' ', '');
      cnpj = cnpj.replaceAll("/", "");
      cnpj = cnpj.replaceAll(".", "");
      cnpj = cnpj.replaceAll("-", "");
      final response = await http.get(StringsConfig().urlApi+"/autenticar/"+ cnpj+"/"+md5.convert(utf8.encode(senha_text)).toString());
      if (response.statusCode == 200 && json.decode(response.body).length > 0) {
        if(response.body=="[null]"){
          Navigator.pop(context);
          DialogAlert().showMessageDialog(context, "Login", "CNPJ e/ou Senha inválidos!");
        }else{
          UserModel user = UserModel.fromJson(json.decode(response.body)[0]);
          _insert(user);
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
        }
      } else {
        Navigator.pop(context);
        DialogAlert().showMessageDialog(context, "Login", "CNPJ e/ou Senha Inválidos!");
        throw Exception('Failed to load data');
      }
    }
  }


  void _insert(UserModel user) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.nomeColumn : user.nome,
      DatabaseHelper.enderecoColumn  : user.endereco,
      DatabaseHelper.cnpjColumn: user.cnpj,
      DatabaseHelper.senhaColumn: user.senha,
      DatabaseHelper.idColumn: user.id,
    };
    final id = await dbHelper.insert(row);
    usuarioLogado = user;
  }

  Future<bool> isLogado(BuildContext context) async {
    final allRows = await dbHelper.queryAllRows();
    if(allRows.length>0){
      usuarioLogado = UserModel.fromJsonDB(allRows.elementAt(0));

      String cnpj = usuarioLogado.cnpj.replaceAll(' ', '');
      cnpj = cnpj.replaceAll("/", "");
      cnpj = cnpj.replaceAll(".", "");
      cnpj = cnpj.replaceAll("-", "");

      final response = await http.get(StringsConfig().urlApi+"/autenticar/"+cnpj +"/"+usuarioLogado.senha);
      if (response.statusCode == 200 && json.decode(response.body).length > 0 && response.body != '[null]') {
        //atualizando os dados do usuario
        UserModel user = UserModel.fromJson(json.decode(response.body)[0]);
        delete(context);
        _insert(user);
        pointsUsuarioLogado = json.decode(response.body)[0]["points"];
        usuarioLogado = user;
        return true;
      } else {
        //usuario mudou a senha
        delete(context);
        usuarioLogado = null;
        return false;
      }
    }else{
      //nenhum logado
      usuarioLogado = null;
      return false;
    }
  }

  Future<bool> delete(BuildContext context) async {
    dbHelper.delete(usuarioLogado.id);
    return isLogado(context);
  }
}