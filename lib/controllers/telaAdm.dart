import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import '../trabalhos.dart';
import 'getAdm.dart';
import 'package:http/http.dart' as http;

class InicialAdm extends StatefulWidget {
  const InicialAdm({Key key}) : super(key: key);

  @override
  _InicialAdmState createState() => _InicialAdmState();
}

class Adm {
  String admId;
  String admTitulo;

  Adm({this.admId, this.admTitulo});
}

class _InicialAdmState extends State<InicialAdm> {
  telasegura() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  List adms = [];
  List admsfiltrados = [];
  bool procurando = false;

  String baseUrl =
      'https://rumanian-straighten.000webhostapp.com/repo/adm/listaAdm.php';

  Future<dynamic> getAdm() async {
    var response = await Dio().get(baseUrl);
    print(response.data);
    return response.data;
  }

  void initState() {
    telasegura();
    getAdm().then((dados) {
      setState(() {
        adms = admsfiltrados = dados;
      });
    });

    super.initState();
  }

  void _filterAdms(value) {
    setState(() {
      admsfiltrados = adms
          .where((administrador) =>
              administrador['nome']
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              administrador['id'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFC75555);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC75555),
        centerTitle: true,
        title: !procurando
            ? Text(
                'Administração',
                style: TextStyle(
                  fontFamily: 'ChewyRegular',
                  fontSize: 25,
                ),
              )
            : TextField(
                onChanged: (value) {
                  _filterAdms(value);
                },
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Procure um administrador",
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  // labelText: "Pesquise uma palavra: ",
                  fillColor: Colors.white,
                ),
              ),
        actions: <Widget>[
          procurando
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.procurando = false;
                      admsfiltrados = adms;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.procurando = true;
                    });
                  },
                )
        ], //IconButton
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: admsfiltrados.length > 0
            ? ListView.builder(
                itemCount: admsfiltrados.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: Text('O que você deseja fazer ?'),
                            children: [
                              SimpleDialogOption(
                                onPressed: () {},
                                child: const Text('Deletar'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {},
                                child: const Text('Atualizar'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {},
                                child: const Text('Ver Informações'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      // elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: ListTile(
                          title: Text(admsfiltrados[index]['nome']),
                          subtitle: Text(admsfiltrados[index]['email']),
                        ),
                      ),
                    ),
                  );
                })
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC75555)),
                ),
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   backgroundColor: Color(0xFFC75555),
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget constroiAdm(GetAdm adms) => ListTile(
        title: Text(adms.nome),
        subtitle: Text(adms.email),
        onTap: () {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text('O que você deseja fazer ? '),
                children: [
                  SimpleDialogOption(
                    onPressed: () {},
                    child: const Text('Deletar'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {},
                    child: const Text('Atualizar'),
                  ),
                ],
              );
            },
          );
        },
      );
}
