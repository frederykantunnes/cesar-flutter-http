
class UserModel {
  final int id;
  final String nome;
  final String cnpj;
  final String senha;
  final String endereco;

  UserModel({this.id, this.nome, this.cnpj, this.senha,
    this.endereco});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json['id'],
        nome: json['name'],
        cnpj: json['cnpj'],
        senha: json['password'],
        endereco: json['address']
    );
  }

  factory UserModel.fromJsonDB(Map<String, dynamic> json){
    return UserModel(
        id: json['id'],
        nome: json['nome'],
        cnpj: json['cnpj'],
        senha: json['senha'],
        endereco: json['endereco']
    );
  }
}