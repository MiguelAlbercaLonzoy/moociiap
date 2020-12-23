import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moociiap/Model/Token.dart';
import 'package:moociiap/Model/cursoModel.dart';
import 'package:moociiap/Pages/MiniCurso.dart';

import 'SesionVideo.dart';


class ListCursos extends StatefulWidget {

  final Data data;
  ListCursos({this.data});
  @override
  _ListCursos createState() => _ListCursos();
}





class _ListCursos extends State<ListCursos> {
  List<Curso> _cursos = List<Curso>();

  Future<List<Curso>> fetchCursos() async {
    String token = widget.data.text;
    final response = await http.get("http://192.168.0.11:9092/apisis/curso",headers: {'Authorization': 'Bearer $token'});

    var cursos = List<Curso>();

    if(response.statusCode == 200){
      var cursosJson = json.decode(response.body);
      for(var cursoJson in cursosJson){
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


  Widget MisCursos(){
    return GestureDetector(onTap: () {Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(
            builder:(BuildContext context) => SesionVideo()
        )
    );
    },
      child: Scaffold(
          body: ListView.builder(
            itemBuilder: (contex, index){
              Curso curso = _cursos[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Min_Curso(curso.nomCursos, curso.imagen, curso.idpersona.nombPer),
                        MaterialButton(
                          elevation: 10.0,
                          minWidth: 80.0,
                          height: 30.0,
                          color: Color(0xFF6A040F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)
                          ),
                          child: Text("Inscribirme", style: TextStyle(color: Color(0xFFFAA307), fontSize: 15.0),),
                          onPressed: (
                              ){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SesionVideo()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: _cursos.length,
          )
      ),
    );

}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Escoge un Curso:", style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold,),),
              Container(height: 800,child: GestureDetector(onTap: () {
                MaterialPageRoute(builder: (context) => SesionVideo());
              },child: MisCursos()))
            ]
          ),
        ) );
  }
}

