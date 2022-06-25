import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repositorio/controllers/telaAdm.dart';

class AdmApi {
  static Future<List<GetAdm>> pegaAdm(String query) async {
    final url = Uri.parse(
        'https://rumanian-straighten.000webhostapp.com/repo/adm/listaAdm.php');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List adms = json.decode(response.body);
      return adms.map((json) => GetAdm.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}

class GetAdm {
  String id;
  String login;
  String nome;
  String email;
  String senha;

  GetAdm({this.id, this.login, this.nome, this.email, this.senha});

  factory GetAdm.fromJson(Map<String, dynamic> json) => GetAdm(
      id: json['id'],
      login: json['login'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;
    return data;
  }
}
