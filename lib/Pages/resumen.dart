import 'package:flutter/material.dart';
import 'tarjeta.dart';

class Resumen extends StatefulWidget{

  @override
  _Resumen createState() => _Resumen();
}

class _Resumen extends State<Resumen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(padding: const EdgeInsets.all(20.0),
                  child: Text("Breve descripcion del curso", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25.0),
                  )
              ),
            ]
        ),
      ),
    );
  }
}