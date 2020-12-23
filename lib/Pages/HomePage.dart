import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moociiap/Blog/addBlog.dart';
import 'package:moociiap/Login/login_google.dart';
import 'package:moociiap/Model/Token.dart';
import 'package:moociiap/Model/cursoModel.dart';
import 'package:moociiap/Pages/WelcomePage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moociiap/NetworkHandler.dart';

import 'Curso.dart';
import 'MisCursos.dart';
import 'PerfilPage.dart';

class HomePage extends StatefulWidget {
  final Data data;
  HomePage({Key key, this.data}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = FlutterSecureStorage();
  int currentState = 0;
  List<Curso> _cursos = List<Curso>();
  String userName;
  String userImage;
  String userCorreo;
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

  NetworkHandler networkHandler = NetworkHandler();

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

    super.initState();
    fetchCursos().then((value){
      setState(() {
        _cursos.addAll(value);
      });
    });
    _handleInfo().then((value){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [MisCursos(data: widget.data), ListCursos(data: widget.data)];
    List<String> titleString = ["Mi Aprendizaje", "Cursos Disponibles"];
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: GestureDetector(onTap: () {
                MaterialPageRoute(builder: (context) => PerfilPage());
              },
                child: Column(
                  children: <Widget>[
                    GestureDetector(onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder:(BuildContext context) => PerfilPage()
                          )
                      );

                    },
                        child: Container(height: 100, width: 100, child: Image(image: NetworkImage(userImage,)),)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("@$userName"),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text("Todos los Cursos"),
              trailing: Icon(Icons.library_books_rounded),
              onTap: () {},
            ),
            ListTile(
              title: Text("Cursos de Categoria 1"),
              trailing: Icon(Icons.account_tree_outlined),
              onTap: () {},
            ),
            ListTile(
              title: Text("Cursos de Categoria 2"),
              trailing: Icon(Icons.account_tree_outlined),
              onTap: () {},
            ),
            ListTile(
              title: Text("Ajustes"),
              trailing: Icon(Icons.settings),
              onTap: () {},
            ),
            ListTile(
              title: Text("Cerrar Sesion"),
              trailing: Icon(Icons.power_settings_new),
              onTap: logout,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(titleString[currentState]),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddBlog()));
        },
        child: Text(
          "+",
          style: TextStyle(fontSize: 40),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: currentState == 0 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 0;
                    });
                  },
                  iconSize: 40,
                ),
                IconButton(
                  icon: Icon(Icons.library_books),
                  color: currentState == 1 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 1;
                    });
                  },
                  iconSize: 40,
                )
              ],
            ),
          ),
        ),
      ),
      body: widgets[currentState],
    );
  }






  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }
}
