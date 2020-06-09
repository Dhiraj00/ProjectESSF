import 'package:flutter/material.dart';



void main() =>
    runApp(new MyApp()); // main method for the start of the application

class MyApp extends StatelessWidget {
  //create the myapp class which extends stateless widgets,
//stateless means which donn't have any state.
  @override // we want to make something custom for us.
  Widget build(BuildContext context) {
    // name of the method build

    return new MaterialApp(
      
      //we a re getting matrial app, as we are dealing with material app
      debugShowCheckedModeBanner:
          false, //to clear off the screen from the debug mark.
      initialRoute: LoginPage.id, // as we say we have home named as login page
      theme: new ThemeData(
          //chnage the theme for loginpage
          primarySwatch:
              Colors.blue //primary swatch helps to give the perfect color
          ),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  static const String id = "LogInPage";
  //as we have Loginpage but no class created, so we need to create the class extending
//stateful wigdet as we need to add changes related images.

  @override //as we are overriding for the stateful widget.
  State createState() => new LoginPageState();
  //creating a method and make another state class which will have
  //al the states

}

class LoginPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formkey = new GlobalKey<FormState>();
  String email, password;
  @override
  void initState() {
    super.initState();
  }

  void _login() {}

  void performLogin() {}
  Widget _companyLogo() {
    return Column(
        // inorder to make the logo stay in centre
        children: <Widget>[
          new Container(
            child: new Image(
              image: new AssetImage("assets/Givemeshelter.png"),
              height: 100.0,
              width: 100.0,
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ]);
  }

  Widget _nameTF() {
    return Text(
      "ESSF",
      maxLines: 2,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.yellow,
        fontWeight: FontWeight.w900,
        fontSize: 40,
      ),
    );
  }

  Widget _formTF() {
    return Form(
        child: Theme(
            data: new ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
            ),
            child: Container(
              padding: const EdgeInsets.all(60.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new TextFormField(
                    validator: (input) {
                      if (input.isEmpty && !input.contains('@')) {
                        return ("please type an email");
                      }
                      return null;
                    },
                    onSaved: (input) => email = input,
                    decoration: new InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        )),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  new TextFormField(
                    validator: (input) {
                      if (input.length < 6) {
                        return ("Password must have 6 characters");
                      }
                      return null;
                    },
                    onSaved: (input) => email = input,
                    decoration: new InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        )),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        MaterialButton(
                            onPressed: () {}, child: Text("Forgot Password ?")),
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: (){},
                          child: Text("LogIn"),
                          color: Colors.blueGrey,
                          padding: EdgeInsets.only(
                              left: 99.5, right: 99.5, top: 12, bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        )
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                          
                          },
                          child: Text("Register"),
                          color: Colors.blueGrey,
                          padding: EdgeInsets.only(
                              left: 90, right: 90, top: 12, bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        )
                      ]),
                  new Column(
                    children: <Widget>[
                      Text(
                        "--OR--",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 10.0),
                      Text("Sign in with",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          )),
                      SizedBox(height: 20.0),
                    ],
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        new GestureDetector(
                            onTap: () => print('Login with facebook'),
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                      blurRadius: 6.0,
                                    )
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/FacebookLogo.png",
                                    ),
                                  )),
                            )),
                        new GestureDetector(
                            onTap: () => print('Login with Google'),
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                      blurRadius: 6.0,
                                    )
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/googlelogo.png",
                                    ),
                                  )),
                            )),
                      ])
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey, body: _body(), backgroundColor: Colors.blueAccent);
  }

  _body() {
    return Center(
        child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
      _companyLogo(),
      SizedBox(height: 20.0),
      _nameTF(),
      _formTF(),
    ])));
  }
}

class Navigatior {
  static of(BuildContext context) {}
}
