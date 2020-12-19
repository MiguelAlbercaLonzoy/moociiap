import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'HomePage.dart';
import 'SignUpPage.dart';
import 'package:http/http.dart' as http;

import 'SinInPage.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {

  AnimationController _controller1;
  Animation<Offset> animation1;
  AnimationController _controller2;
  Animation<Offset> animation2;
  bool _isLogin = false;
  Map data;
  final facebookLogin = FacebookLogin();


  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount _currentUser;
  _handleSignIn() async{
    try{
      await _googleSignIn.signIn();
      initState();

    }
    catch(error){
      print(error);
    }
  }




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green[200]],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SlideTransition(
                  position: animation1,
                  child: Text(
                    "Bienvenidos a IIAPMOOC",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                SlideTransition(
                  position: animation1,
                  child: Text(
                    "Un bosque de aprendizaje por descubrir",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 38,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    _handleSignIn();

                  },
                  child: SlideTransition(
                    position: animation2,
                    child: InkWell(
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width - 120,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/google.png",
                                  height: 25,
                                  width: 25,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "Registrarme con Google",
                                  style: TextStyle(fontSize: 16, color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _isLogin ? Future.delayed(Duration.zero, () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));}) : boxContainer(
                    "assets/facebook1.png", "Registrarme con Facebook", onFBLogin),

                SizedBox(
                  height: 20,
                ),
                boxContainer(
                  "assets/email2.png",
                  "Registrarme con Correo",
                  onEmailClick,
                ),
                SizedBox(
                  height: 20,
                ),
                SlideTransition(
                  position: animation2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "¿Ya tienes una cuenta?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ));
                        },
                        child: Text(
                          "Inicia Sesion",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  onFBLogin(result) async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken;
        final response = await http.get(
            "https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token");
        final data1 = json.decode(response.body);
        print(data);
        setState(() {
          _isLogin = true;
          data = data1;
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _isLogin = false;
        });
        break;
      case FacebookLoginStatus.error:
        setState(() {
          _isLogin = false;
        });
        break;
    }
  }

  onEmailClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignUpPage(),
    ));
  }

  Widget boxContainer(String path, String text, onClick) {
    return SlideTransition(
      position: animation2,
      child: InkWell(
        onTap: () => onFBLogin(path),
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 120,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Image.asset(
                    path,
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(width: 20),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if(_currentUser != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });

    //animation 1
    _controller1 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    animation1 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeOut),
    );

// animation 2
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.elasticInOut),
    );

    _controller1.forward();
    _controller2.forward();
  }
}
