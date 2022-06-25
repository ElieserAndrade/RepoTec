import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repositorio/CadastraTraballho.dart';

import 'package:repositorio/main.dart';
import 'package:repositorio/trabalhos.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TelaLogin.dart';
import 'controllers/telaAdm.dart';
//import 'models/api.dart';
//
//import 'package:http/http.dart' as http;

//import 'package:cloud_firestore/cloud_firestore.dart';

class RepoPage extends StatefulWidget {
  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("EM BREVE"),
          );
        });
  }

  List trabalhos = [];
  List trabalhosfiltrados = [];
  bool procurando = false;

  String baseUrl =
      'https://rumanian-straighten.000webhostapp.com/repo/repo.php';

  Future<dynamic> getRepo() async {
    var response = await Dio().get(baseUrl);
    print(response.data);
    return response.data;
  }

  void initState() {
    getRepo().then((dados) {
      setState(() {
        trabalhos = trabalhosfiltrados = dados;
      });
    });
    logado();
    super.initState();
  }

  void _filterTrabalhos(value) {
    setState(() {
      trabalhosfiltrados = trabalhos
          .where((work) =>
              work['id'].toLowerCase().contains(value.toLowerCase()) ||
              work['dev1'].toLowerCase().contains(value.toLowerCase()) ||
              work['dev2'].toLowerCase().contains(value.toLowerCase()) ||
              work['dev3'].toLowerCase().contains(value.toLowerCase()) ||
              work['curso'].toLowerCase().contains(value.toLowerCase()) ||
              work['titulo'].toLowerCase().contains(value.toLowerCase()) ||
              work['orientador'].toLowerCase().contains(value.toLowerCase()) ||
              work['descri'].toLowerCase().contains(value.toLowerCase()) ||
              work['projeto'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  String loginSaved;
  Future<void> logado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginSaved = prefs.getString('login');
    });
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginSaved = null;
      prefs.remove("login");
    });
  }

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFC75555);
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        backgroundColor: Color(0xFFC75555),
        centerTitle: true,
        title: procurando
            ? TextField(
                onChanged: (value) {
                  _filterTrabalhos(value);
                },
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Pesquise um trabalho",
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
              )
            : Text(
                'RepoTec',
                style: TextStyle(
                  fontFamily: 'ChewyRegular',
                  fontSize: 25,
                ),
              ),
        actions: <Widget>[
          procurando
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.procurando = false;
                      trabalhosfiltrados = trabalhos;
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
        ],
      ), //IconB
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            loginSaved != null || loginSaved == ""
                ? UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFFC75555)),
                    accountName: new Text("$loginSaved"),
                    accountEmail: Text(''),
                    onDetailsPressed: () {},
                  )
                : UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFFC75555)),
                    accountName: ElevatedButton(
                      child: Text(
                        'Entrar',
                        style: TextStyle(color: Color(0xFFC75555)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => (TelaLogin()),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.white; // Use the component's default.
                          },
                        ),
                      ),
                    ),
                    accountEmail: Text(''),
                  ),
            loginSaved != null || loginSaved == ""
                ? ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text(
                      "Logout",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onTap: () {
                      logout();
                    },
                  )
                : ListTile(
                    //leading: Icon(Icons.logout_outlined),
                    title: Text(
                      "",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
            loginSaved != null || loginSaved == ""
                ? ListTile(
                    leading: Icon(Icons.upgrade),
                    title: Text(
                      "Cadastrar Projeto",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => (CadProj())),
                      );
                    },
                  )
                : ListTile(
                    //leading: Icon(Icons.logout_outlined),
                    title: Text(
                      "",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
            loginSaved != null || loginSaved == ""
                ? ListTile(
                    leading: Icon(Icons.admin_panel_settings),
                    title: Text(
                      "Tela de Administração",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => (InicialAdm())),
                      );
                    },
                  )
                : ListTile(
                    //leading: Icon(Icons.logout_outlined),
                    title: Text(
                      "",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: trabalhosfiltrados.length > 0
            ? Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(
                        trabalhosfiltrados.length,
                        (index) {
                          // String nome =  trabalhosfiltrados[index]['nome'];
                          return Center(
                              child: Container(
                                  child: 
                                   Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 0.09,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                   // log(trabalhosfiltrados[index].pdf);
                    //log('[ trabalhosfiltradostrabalhosfiltrados[index]['curso']}');
                    Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (BuildContext context) =>
                           (TrabalhosPage(
                                      trabalhoID: index,
                                      curso: trabalhosfiltrados[index]['curso'],
                                    )),
                     ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            trabalhosfiltrados[index]['titulo']
                                            .toString(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.picture_as_pdf_outlined,
                        color: Color(0xFFC75555),
                        size: 70,
                      ),
                       Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Center(
                          child: Text(
                            trabalhosfiltrados[index]['curso']
                                            .toString(),
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Text(
                              trabalhosfiltrados[index]['projeto']
                                                .toString(),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                            ),
                            child: Text(
                              'Orientador \n' +
                                  trabalhosfiltrados[index]['orientador']
                                                .toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ))); 
                                  
                                  
                                  
                                  
                                  
                                  
                         
                        },
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC75555)),
                ),
              ),
      ),
    );
  }
}
