import 'dart:convert';

import 'package:dio/dio.dart';

class AtualizaTrabalhoDados {
  // static Stream pegaValores() =>
  //     Stream.periodic(Duration(seconds: 1)).asyncMap((_) => getCompanehiros());

  Future<dynamic> getCompanehiros(var id) async {
    var response = await Dio().post(
      'https://rumanian-straighten.000webhostapp.com/repo/update.php',
      data: {'id': id},
      options: Options(contentType: 'application/json'),
    );
    print(response.data);
    String conteudo = response.data;
    List valores = json.decode(conteudo);
    List<Valores> _retornovalor =
        valores.map((json) => Valores.fromJson(json)).toList();

    return _retornovalor;
  }
}

class Valores {
  String dev1;
  String dev2;
  String dev3;
  String projeto;
  String curso;
  String ciclo;
  String titulo;
  String orientador;
  String resumo;

  Valores({
    this.dev1,
    this.dev2,
    this.dev3,
    this.projeto,
    this.curso,
    this.ciclo,
    this.titulo,
    this.orientador,
    this.resumo,
  });

  Valores.fromJson(Map<String, dynamic> json) {
    dev1 = json['dev1'];
    dev2 = json['dev2'];
    dev3 = json['dev3'];
    curso = json['curso'];
    ciclo = json['ciclo'];
    titulo = json['titulo'];
    orientador = json['orientador'];
    projeto = json['projeto'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['dev1'] = this.dev1;
    data['dev2'] = this.dev2;
    data['dev3'] = this.dev3;
    data['curso'] = this.curso;
    data['ciclo'] = this.ciclo;
    data['titulo'] = this.titulo;
    data['orientador'] = this.orientador;
    data['projeto'] = this.projeto;
    return data;
  }
}

void main() async {
  List resultado = await AtualizaTrabalhoDados().getCompanehiros(1);
  print(resultado);
}
