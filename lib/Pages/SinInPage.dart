import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moociiap/Model/Token.dart';
import 'package:moociiap/Pages/Curso.dart';
import 'package:moociiap/Pages/ForgetPassword.dart';
import 'package:moociiap/Pages/HomePage.dart';
import 'package:moociiap/Pages/SignUpPage.dart';
import "package:flutter/material.dart";

import '../NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';




class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}





class _SignInPageState extends State<SignInPage> {



  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,

      decoration: BoxDecoration(image: const DecorationImage(image: AssetImage("assets/images/iiapsanmartin.png"),fit: BoxFit.cover),
        gradient: LinearGradient(
          colors: [Color(0xFFE85D04), Color(0xFF6A040F)],
          begin: const FractionalOffset(0.0, 1.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.repeated,
        ),
      ),
      child: Form(
        key: _globalkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                ),
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(image: const DecorationImage(image: AssetImage("assets/images/iiaplogo.png"),fit: BoxFit.scaleDown),borderRadius: BorderRadius.circular(100.0)
                    ),

                  ),

                Text(
                  "Iniciar Sesion con Correo",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing:1,
                    color: Colors.grey
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                usernameTextField(),
                SizedBox(
                  height: 15,
                ),
                passwordTextField(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                      child: Text(
                        "Olvidaste tu clave?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        "Nuevo Usuario?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {

                    setState(() {
                      circular = true;
                    });

                    //Login Logic start here
                    Map<String, String> data = {
                      "nombreUsuario": _usernameController.text,
                      "password": _passwordController.text,
                    };
                    var response = await networkHandler.post("/auth/login", data);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      Map<String, dynamic> output = json.decode(response.body);
                      print(output["token"]);
                      final token = output["token"];
                      final data = Data(text: token);
                      await storage.write(key: "token", value: output["token"]);
                      setState(() {
                        validate = true;
                        circular = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(data: data),
                          ));
                    } else {
                      Map<String, dynamic> output = json.decode(response.body);
                      setState(() {
                        validate = false;
                        errorText = output.toString();
                        circular = false;
                      });
                    }

                    // login logic End here
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff00A86B),
                    ),
                    child: Center(
                      child: circular
                          ? CircularProgressIndicator()
                          : Text(
                        "Iniciar Sesion",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // Divider(
                //   height: 50,
                //   thickness: 1.5,
                // ),
              ],
            ),
          ),
        ),
      ),
        ),
    );
  }

  Widget usernameTextField() {
    return Column(
      children: [
        Text("Correo", style: TextStyle(color: Colors.white,),),
        TextFormField(style: TextStyle(color: Colors.white),
          controller: _usernameController,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget passwordTextField() {
    return Column(
      children: [
        Text("Contraseña", style: TextStyle(color: Colors.white,),),
        TextFormField(style: TextStyle(color: Colors.white),
          controller: _passwordController,
          obscureText: vis,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off  : Icons.visibility),color: Colors.green,
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            helperStyle: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        )
      ],
    );
  }

}
