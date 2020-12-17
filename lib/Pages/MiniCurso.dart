import 'package:flutter/material.dart';
import 'SesionVideo.dart';


class Min_Curso extends StatelessWidget{
  String curso;
  String imagen;
  Min_Curso(this.curso, this.imagen);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, bottom: 20.0, top: 20.0),
      child: GestureDetector(
        onTap: () {
          MaterialPageRoute(builder: (context) => SesionVideo());
        },
        child: Container(
          width: 250,
          height: 150,
          decoration: _boxDecoration(context),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SesionVideo()));
                },
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(image: NetworkImage(imagen), fit: BoxFit.cover)),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(child: Icon(Icons.favorite_border, color: Colors.white,)),

                    ],
                  ),
                ),),
              Container(
                height: 25.0,
                  child:
                      Center(child: Text(this.curso, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontStyle: FontStyle.italic))),
                  ),
              Container(
                height: 25.0,
                child:
                Center(child: Text("Docente:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontStyle: FontStyle.italic))),
              )
            ],
          ),


        ),
      ),

    );

  }
  BoxDecoration _boxDecoration(context){
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black45,
          offset: Offset(4.0, 4.0)
        )
      ]
    );
  }
}
class ListaCursosMin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Min_Curso("Agricultura", "https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg"),
          Min_Curso("Cosecha", "https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg"),
          Min_Curso("Agricultura", "https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg"),
          Min_Curso("Cosecha", "https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg"),
        ],
      ),
    );
  }
}

