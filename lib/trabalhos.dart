import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:repositorio/AbrirPDF.dart';
//import 'package:repositorio/TelaLogin.dart';
import 'package:repositorio/repo.dart';
import 'package:repositorio/updateTrabalho.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable   nao faz sentrido jsjsjsjsjsj
class TrabalhosPage extends StatefulWidget {
  final int trabalhoID;
  final String curso;

  final bool online = true;

  const TrabalhosPage({Key key, this.trabalhoID, this.curso}) : super(key: key);

  @override
  _TrabalhosPageState createState() => _TrabalhosPageState();
}

class _TrabalhosPageState extends State<TrabalhosPage> {
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("EM BREVE"),
          );
        });
  }

  String loginSaved;
  Future<void> teste() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginSaved = prefs.getString('login');
    });
  }

  @override
  void initState() {
    teste();
    super.initState();
  }

  String baseUrl =
      'https://rumanian-straighten.000webhostapp.com/repo/repo.php';

  Future<dynamic> getRepo() async {
    var response = await Dio().get(baseUrl);
    print(response.data);
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        title: Text(
          widget.curso,
          style: TextStyle(fontFamily: 'ChewyRegular', fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFC75555),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () {
            Navigator.pop(context);
            //createAlertDialog(context);
          },
        ), //IconButton
      ),
      body: FutureBuilder(
        future: getRepo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              String nome = snapshot.data[widget.trabalhoID]['titulo'];
              bool online = true;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Icon(
                          Icons.picture_as_pdf_outlined,
                          //color: color,
                          size: 200,
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          nome,
                          style: TextStyle(
                            fontFamily: 'ChewyRegular',
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]
                                          ['orientador'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]['curso'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]['ciclo'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]
                                          ['projeto'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]
                                          ['dev1'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                          
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]['dev2'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      snapshot.data[widget.trabalhoID]
                                          ['dev3'],
                                      style: TextStyle(
                                          fontFamily: 'ChewyRegular',
                                          color: Colors.grey[900]),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                snapshot.data[widget.trabalhoID]['descri'],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontFamily: 'ChewyRegular',
                                    color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton.extended(
                          heroTag: 'abre',
                          label: const Text(
                            'Abrir PDF',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'ChewyRegular',
                            ),
                          ),
                          onPressed: () {
                            print(snapshot.data[widget.trabalhoID]
                                        ['pdf']);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => (ViewPdf(
                                    pdf: (snapshot.data[widget.trabalhoID]
                                        ['pdf']),
                                  )),
                                ));
                          },
                          icon: const Icon(Icons.launch),
                          backgroundColor: Color(0xFFC75555),
                        ),
                      ),
                    ),
                    Container(child: Builder(builder: (context) {
                      if (loginSaved != null) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FloatingActionButton.extended(
                                        heroTag: 'atualiza',
                                        label: const Text(
                                          'Atualizar Projeto',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'ChewyRegular',
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      UpdateProj(
                                                        id: widget.trabalhoID
                                                            .toString(),
                                                        id2: snapshot.data[
                                                                widget
                                                                    .trabalhoID]
                                                            ['id'],
                                                        dev1: snapshot.data[
                                                                widget
                                                                    .trabalhoID]
                                                            ['dev1'],
                                                        dev2: snapshot.data[
                                                                widget
                                                                    .trabalhoID]
                                                            ['dev2'],
                                                        dev3: snapshot.data[
                                                                widget
                                                                    .trabalhoID]
                                                            ['dev3'],
                                                        ciclo: snapshot.data[
                                                                widget
                                                                    .trabalhoID]
                                                            ['ciclo'],
                                                        curso: snapshot.data[
                                                                widget
                                                                    .trabalhoID]
                                                            ['curso'],
                                                        orientador:
                                                            snapshot.data[widget
                                                                    .trabalhoID]
                                                                ['orientador'],
                                                        resumo: snapshot.data[
                                                                widget
                                                                    .trabalhoID]
                                                            ['descri'],
                                                        projeto: snapshot.data[
                                                                widget
                                                                    .trabalhoID]
                                                            ['projeto'],
                                                        titulo: snapshot.data[
                                                                widget
                                                                    .trabalhoID]
                                                            ['titulo'],
                                                      )));
                                        },
                                        icon: const Icon(Icons.update),
                                        backgroundColor: Color(0xFFC75555),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FloatingActionButton.extended(
                                        heroTag: 'deleta',
                                        label: const Text(
                                          'Excluir Projeto',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'ChewyRegular',
                                          ),
                                        ),
                                        onPressed: () => showAlertDialog(
                                          context,
                                          snapshot.data[widget.trabalhoID]
                                              ['id'],
                                              snapshot.data[widget.trabalhoID]
                                              ['pdf'],
                                              
                                        ),
                                        icon: const Icon(Icons.delete),
                                        backgroundColor: Color(0xFFC75555),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else
                        return Text('');
                    })),
                  ],
                ),
              );
            } else {
              return Center(child: Text('Nenhum dado para mostar'));
            }
          } else {
            return Center(
              child: Container(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC75555)),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  showAlertDialog(BuildContext context, String id, String pdf) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancelar",
        style: TextStyle(color: Color(0xFFC75555)),
      ),
      onPressed: () {
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (BuildContext context) => RepoPage()));

        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Excluir",
        style: TextStyle(color: Color(0xFFC75555)),
      ),
      onPressed: () {
        uploadDados(id, pdf);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção"),
      content: Text("Você deseja Realmente Excluir o Trabalho ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  uploadDados(String idDelete, String pdfa) async {
    String uploadurl =
        "https://rumanian-straighten.000webhostapp.com/repo/deletaTrabalho.php";
    //     "http://192.168.0.101:80/repo/upardados.php";

    String id = idDelete;
    String pdf = pdfa;
    Map data = {
      "id": id,
      'pdf': pdf
    };
    var respBody = jsonEncode(data);
    print(respBody);

    var res = await http
        .post(Uri.parse(uploadurl),
            headers: {"Accept": "application/json"}, body: respBody)
        .catchError((e) {
      print('O erro e: $e');
    });

    if (res.statusCode == 200) {
      print('dados enviados');
      log(res.body);
      return Apagado(context);
      //print response from server
    } else {
      print("Erro Durante a Conexão com o Servidor.");
    }
  }

  Apagado(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: Color(0xFFC75555)),
      ),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => RepoPage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção !"),
      content: Text("Dados Apagados com Sucesso!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Future<void> _PopUpExcluiTrabalho(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Pesquisar'),
  //           actions: <Widget>[
  //             FloatingActionButton.extended(
  //               backgroundColor: Color(0xFFC75555),
  //               onPressed: () {
  //                 setState(() {
  //                   Navigator.pop(context);
  //                 });
  //               },
  //               label: Text('CANCEL'),
  //             ),
  //             FloatingActionButton.extended(
  //               backgroundColor: Color(0xFFC75555),
  //               onPressed: () {
  //                 setState(() {
  //                   Navigator.pop(context);
  //                 });
  //               },
  //               label: Text('Cancelar'),
  //             ),
  //           ],
  //         );
  //       });
  // }
}
