import 'package:essf/LoginPage.dart';
import 'package:essf/auth.dart';
import 'package:essf/platform_alert.dart';

import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({this.auth});
  final AuthBase auth;

  //as we have Loginpage but no class created, so we need to create the class extending
//stateful wigdet as we need to add changes related images.

  @override //as we are overriding for the stateful widget.
  State createState() => new RegisterPageState(auth: auth);
}
//creating a method and make another state class which will have
//al the states

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  final _formkey = new GlobalKey<FormState>();

  AuthBase auth;
  RegisterPageState({@required this.auth});
  @override
  void initState() {
    auth = Auth();
    super.initState();
  }

  Future<void> _signInwithGoogle() async {
    try {
      await auth.signInwithGoogle();
    } catch (e) {
      PlatformAlertDialog(
        title: 'Sign IN Failed',
        content: e.toString(),
        defaultActionText: 'OK',
        cancelActionText: null,
      ).show(context);
    }
  }

  Future<void> _signInwithFacebook() async {
    try {
      await auth.signInwithFacebook();
    } catch (e) {
      PlatformAlertDialog(
        title: 'Sign IN Failed',
        content: e.toString(),
        defaultActionText: 'OK',
        cancelActionText: null,
      ).show(context);
    }
  }

  Future<void> _createUserWithEmailAndPassword() async {
    try {
      await auth.createUserWithEmailAndPassword(_email, _password);
      
   
     Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LogInPage(),
          ));
           PlatformAlertDialog(
        title: 'Verfication Required',
        content: 'Email Verification Sent.Please check your Email, Thanks.',
        defaultActionText: 'OK',
        cancelActionText: null,
      ).show(context);
     
    } catch (error) {
      PlatformAlertDialog(
        title: 'Sign Up Failed',
        content: error.toString(),
        defaultActionText: 'OK',
        cancelActionText: null,
      ).show(context);
      _emailController.clear();
      _passwordController.clear();
    }
  }

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
        key: _formkey,
        autovalidate: true,
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
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String _email) {
                      if (!_email.contains('@') || _email.isEmpty)
                        return ("please type an email");

                      return null;
                    },
                    decoration: new InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        )),
                  ),
                  new TextFormField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    validator: (_password) {
                      if (_password.length < 8)
                        return ("Password must have 6 characters");

                      return null;
                    },
                    decoration: new InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        )),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: _createUserWithEmailAndPassword,
                          child: Text("Register now"),
                          color: Colors.blueGrey,
                          padding: EdgeInsets.only(
                              left: 74.5, right: 74.5, top: 12, bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        )
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogInPage(),
                                ));
                          },
                          child: Icon(Icons.arrow_back_ios),
                          color: Colors.lightBlue,
                          padding: EdgeInsets.only(
                              left: 3.5, right: 3.5, top: 7, bottom: 7),
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
                        new FlatButton(
                            onPressed: _signInwithFacebook,
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
                        new FlatButton(
                            onPressed: _signInwithGoogle,
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
    return new Scaffold(body: _body(), backgroundColor: Colors.blueAccent);
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
