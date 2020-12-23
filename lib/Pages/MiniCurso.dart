import 'package:flutter/material.dart';
import 'SesionVideo.dart';


class Min_Curso extends StatelessWidget{
  String curso;
  String imagen;
  String idpersona;
  Min_Curso(this.curso, this.imagen, this.idpersona);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, bottom: 20.0, top: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder:(BuildContext context) => SesionVideo()
              )
          );
        },
        child: Container(
          width: 250,
          height: 190,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: NetworkImage(imagen), fit: BoxFit.cover),
          ),
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Container(
                height: 30.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white.withOpacity(0.5),),
                child:
                Center(child: Text("Docente: "+this.idpersona, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontStyle: FontStyle.italic))),
              ),

              Container(
                height: 40.0,

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white.withOpacity(0.5),),
                  child:
                      Center(child: Text(this.curso, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontStyle: FontStyle.italic),textAlign: TextAlign.center,)),
                  ),


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
          Min_Curso("Agricultura", "https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg","1"),
          Min_Curso("Cosecha", "https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg","2"),
          Min_Curso("Agricultura", "https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg","3"),
          Min_Curso("Cosecha", "https://encolombia.com/wp-content/uploads/2020/01/Agricultura.jpg","4"),
        ],
      ),
    );
  }
}

