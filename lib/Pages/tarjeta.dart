import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moociiap/Pages/listaclases.dart';
import 'package:moociiap/Pages/resumen.dart';

class Tarjeta extends StatefulWidget {
  @override
  _Tarjeta createState() => _Tarjeta();

}

class _Tarjeta extends State<Tarjeta> {
  //final referenceDatabase = FirebaseDatabase.instance;
  bool ventana = true;
  void changeState(){
    if(ventana){
      setState(() {
        ventana = false;
      });
    }else
      setState(() {
        ventana = true;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: () => changeState(),
                child: Text('Contenido del Curso', style: GoogleFonts.varelaRound(
                    fontWeight: FontWeight.bold,
                    color: ventana == true ? Colors.blue : Colors.grey,
                    fontSize: 15),),),
              FlatButton(
                onPressed: () => changeState(),
                child: Text('Descripcion', style: GoogleFonts.varelaRound(
                    fontWeight: FontWeight.bold,
                    color: ventana != true ? Colors.blue : Colors.grey,
                    fontSize: 15),),),
            ],
          ),
          ventana == true ? ListaClases() : Resumen(),


        ],),

    );
  }
}
