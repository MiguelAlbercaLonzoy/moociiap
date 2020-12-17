
import 'package:flutter/material.dart';
import 'package:moociiap/CustumWidget/BuscarCursos.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:moociiap/Pages/MiniCurso.dart';

class BusquedaCursos extends StatefulWidget {
  final String busqueda;
  BusquedaCursos({this.busqueda});
  @override
  _BusquedaCursos createState() => _BusquedaCursos();
}

class _BusquedaCursos extends State<BusquedaCursos> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: Text('   Buscaste:'+this.widget.busqueda),

      ),
      body: SingleChildScrollView(

          scrollDirection: Axis.vertical,
          child: Column(


            children: <Widget>[

              Container(
                  margin: EdgeInsets.all(25.0),
                  height: 108,
                  child: ListaCursosMin()
              ),

            ],
          )
      ),

    );
  }
}
