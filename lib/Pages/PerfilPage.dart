import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moociiap/Login/login_google.dart';


class PerfilPage extends StatefulWidget {
  @override
  _PerfilPage createState() => _PerfilPage();
}
class _PerfilPage extends State<PerfilPage> {

  File imageFile;
  String userName;
  String userImage;
  String userCorreo;
  _openGallery (BuildContext context) async {
    var  picture= await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile=picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var  picture= await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile=picture;
    }
    );
    Navigator.of(context).pop();
  }
  Future<void> _handleInfo() async{
    try{
      GoogleSignInAccount data = await googleSignIn.signIn() ?? null;
      print(data.toString());
      if(data != null){
        userName = data.displayName;
        userImage = data.photoUrl;
        userCorreo = data.email;
      }
    }catch(error){
      print(error);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleInfo().then((value){
      setState(() {

      });
    });
  }
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Seleccione"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0),),
                  GestureDetector(
                    child: Text("Camara"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
  //retorna  texto si no se ha seleccionado alguna imagen
  Widget decideImageView(){
    if(userImage ==null){
      return CircleAvatar(
          backgroundImage: AssetImage('assets/images/user.png'),
          radius: 50);


    }
    else{
      return  Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(userImage))
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Bienvenid@ $userName"),

        ),
        body: (userName!= null)?Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          decideImageView(),
                          GestureDetector(
                              onTap: () {
                                _showChoiceDialog(context);
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/images/camara2.png'),
                                radius: 30,
                              )
                          ),
                        ],),
                      Container(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(

                          children: <Widget>[
                            Text("Usuario", style: TextStyle(fontSize: 20),),
                            Text(userName, style: TextStyle(fontSize: 20),),
                            Text("Apellidos", style: TextStyle(fontSize: 20),),
                            TextField(),
                            Text("Correo", style: TextStyle(fontSize: 20),),
                            Text(userCorreo, style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                      MaterialButton(
                        elevation: 10.0,
                        minWidth: 160.0,
                        height: 50.0,
                        color: Colors.green,

                        shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Text("Guardar", style: TextStyle(color: Colors.black, fontSize: 20.0),),
                        onPressed: (

                            ){},
                      )
                    ],
                  )
              )
          ),
        ):CircularProgressIndicator()
    );
  }

}
