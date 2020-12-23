import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moociiap/Model/misCursosModelo.dart';
import 'MiniCurso.dart';
import 'package:moociiap/Model/Token.dart';
import 'package:http/http.dart' as http;

class MisCursos extends StatefulWidget {
  final Data data;
  MisCursos({this.data});

  @override
  _MisCursos createState() => _MisCursos();
}

class _MisCursos extends State<MisCursos> {


  List<Curso> _cursos = List<Curso>();

  Future<List<Curso>> fetchCursos() async {
    String token = widget.data.text;
    final response = await http.get("http://192.168.0.11:9092/apisis/curso_inscritos",
        headers: {'Authorization': 'Bearer $token'});

    var cursos = List<Curso>();

    if (response.statusCode == 200) {
      var cursosJson = json.decode(response.body);
      for (var cursoJson in cursosJson) {
        cursos.add(Curso.fromJson(cursoJson));
      }
    }
    return cursos;
  }
  @override
  void initState() {
    fetchCursos().then((value){
      setState(() {
        _cursos.addAll(value);
      });
    });
    super.initState();
  }


  Widget MiCurso() {
    return Scaffold(
        body: ListView.builder(
          itemBuilder: (contex, index) {
            Curso curso = _cursos[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Min_Curso(curso.idcursos.nomCursos, curso.idcursos.imagen, curso.idpersona.nombPer),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: _cursos.length,
        )
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Text("Escoge un Curso:", style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold,),),
                Container(height: 800,child: MiCurso())
              ]
          ),
        )
    );
  }

}


