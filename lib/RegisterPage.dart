import 'package:essf/LoginPage.dart';
import 'package:essf/Platformecxception.dart';
import 'package:essf/auth.dart';
import 'package:essf/platform_alert.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final TextEditingController _nameController = TextEditingController();
  String get _name => _nameController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  final _formkey = new GlobalKey<FormState>();

  AuthBase auth;
  RegisterPageState({@required this.auth});
  @override
  void initState() {
    super.initState();
    auth = Auth();
  }

  void dispose() {
    super.dispose();
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _signInwithGoogle(BuildContext context) async {
    try {
      await auth.signInwithGoogle(context);
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInwithFacebook(BuildContext context) async {
    try {
      await auth.signInWithFacebook(context);
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Error',
      exception: exception,
    ).show(context);
  }

  Future<void> _createUserWithEmailAndPassword(
      BuildContext context, name, email, pasword) async {
    if (_formkey.currentState.validate()) _formkey.currentState.save();
    try {
      await auth.createUserWithEmailAndPassword(
          context, _name, _email, _password);

      Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => LogInPage(),
          ));

      (_formkey.currentState.validate())
          ? PlatformAlertDialog(
                  title: 'Verfication Required',
                  content:
                      'Email Verification Sent.Please check your Email, Thanks.',
                  defaultActionText: 'OK',
                  cancelActionText: null)
              .show(context)
          : PlatformAlertDialog(
                  title: 'Error',
                  content: 'Invalid Credentials',
                  cancelActionText: null,
                  defaultActionText: 'ok')
              .show(context);
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
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
      style: GoogleFonts.arbutus(fontSize: 27.0, color: Colors.yellowAccent),
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
                    focusNode: _nameFocusNode,
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String _name) {
                      if (!_name.contains(' ') || _name.isEmpty)
                        return ("Please type your Full name");

                      return null;
                    },
                    decoration: new InputDecoration(
                        hintText: "Full Name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                  ),
                  new TextFormField(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String _email) {
                      if (_email.isEmpty) {
                        return ("Please type an email");
                      } else if (!_email.contains('@')) {
                        return ("Invalid Email");
                      }

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
                      if (_password.length < 6) {
                        return ("Password must have 6 characters");
                      } else if (!_password.contains(new RegExp(r'[A-Z]'))) {
                        return ("upperCase Required ");
                      } else if (!_password.contains(new RegExp(r'[0-9]'))) {
                        return ("Password should have atleast one single digit");
                      } else if (!_password
                          .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return ("Password needs to have special character");
                      }

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
                          onPressed: () => _createUserWithEmailAndPassword(
                              context, _name, _email, _password),
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
                            Navigator.pop(
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
                            onPressed: () => _signInwithFacebook(context),
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
                            onPressed: () => _signInwithGoogle(context),
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
