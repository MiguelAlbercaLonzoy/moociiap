
import 'package:flutter/material.dart';
import 'MiniCurso.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class MisCursos extends StatefulWidget {
  @override
  _MisCursos createState() => _MisCursos();
}

class _MisCursos extends State<MisCursos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Cursos que estoy Estudiando', style: TextStyle(fontSize: 30),),
              Container(
                height: 500,
                child: Container(
                  height: 500,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        Min_Curso("DOTA 2 Introduccion","https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg"),
                        Min_Curso("DOTA 2 Introduccion","https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg"),
                        Min_Curso("DOTA 2 Introduccion","https://www.conservamosica.org/conica/wp-content/uploads/2016/03/20140719-01.jpg"),
                        Min_Curso("DOTA 2 Introduccion","https://www.conservamosica.org/conica/wp-content/uploads/2016/03/20140719-01.jpg"),
                        Min_Curso("DOTA 2 Introduccion","https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg"),
                        Min_Curso("DOTA 2 Introduccion","https://www.conservamosica.org/conica/wp-content/uploads/2016/03/20140719-01.jpg"),
                      ],
                    ),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}

