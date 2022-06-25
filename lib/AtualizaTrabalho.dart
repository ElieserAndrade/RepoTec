import 'dart:async';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'conexao/DadosTrabalho.dart';

class AtualizaTarabalho extends StatefulWidget {
  final String id;
  final String id2;
  const AtualizaTarabalho({Key key, this.id, this.id2}) : super(key: key);

  @override
  _AtualizaTarabalhoState createState() => _AtualizaTarabalhoState();
}

class _AtualizaTarabalhoState extends State<AtualizaTarabalho> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();
  String dropCurso;
  String dropCiclo;
  String dropProjeto;
  String loginSaved;
  var dev1;
  var dev2;
  var dev3;
//
  ///
//
  //
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController = TextEditingController();
  final PdfController = PdfViewerController();
  final myControllerT = TextEditingController();
  final myControllerO = TextEditingController();
  final myControllerR = TextEditingController();
  StreamController _streamController;
  Stream _stream;

  Response response;
  Response response2;
  String progress;
  Dio dio = new Dio();

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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();

    myController1.dispose();

    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        title: Text(
          "ATUALIZA PROJETO",
          style: TextStyle(fontFamily: 'ChewyRegular', fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFC75555),
        actions: <Widget>[],
      ),
      // body:StreamBuilder(
      //   stream: _stream ,
      //   builder: (context, snapshot) => ,),
    );
  }
}

Stream<List<AtualizaTrabalhoDados>> pegaValores(var id) async* {
  yield await getCompanehiros(id);
}

Future<dynamic> getCompanehiros(var id) async {
  var response = await Dio().post(
    'https://rumanian-straighten.000webhostapp.com/repo/update.php',
    data: {'id': id},
    options: Options(contentType: 'application/json'),
  );
  print(response.data);
  return response.data;
}
