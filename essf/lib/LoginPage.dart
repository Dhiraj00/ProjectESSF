import 'package:essf/RegisterPage.dart';
import 'package:essf/auth.dart';
import 'package:essf/forgot_password.dart';
import 'package:essf/platform_alert.dart';
import 'package:flutter/material.dart';

enum LogInPageFormType { signIn }

class LogInPage extends StatefulWidget {
  LogInPage({this.auth});
  final AuthBase auth;
  @override
  _LogInPageState createState() => _LogInPageState(auth: auth);
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  _LogInPageState({
    @required this.auth,
  });

  final AuthBase auth;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formkey = new GlobalKey<FormState>();
  Future<void> _signInwithGoogle() async {
    try {
      await auth.signInwithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInwithFacebook() async {
    try {
      await auth.signInwithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }
  

  Future<void> _signInWithEmailAndPassword() async {
    try {
     

      await auth.signInWithEmailAndPassword(_email, _password);
    } catch (e) {
      PlatformAlertDialog(
        title: 'Sign IN Failed',
        content: e.toString(),
        defaultActionText: 'OK',
        cancelActionText: null,
      ).show(context);
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

  void _emailEditingComplete() {
    final newFocus =
        _emailController.text.isEmpty ? _passwordFocusNode : _emailFocusNode;

    FocusScope.of(context).requestFocus((newFocus));
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
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: _emailEditingComplete,
                    textInputAction: TextInputAction.next,
                  ),
                  new TextFormField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    validator: (_password) {
                      if (_password.length < 6)
                        return ("Password must have 6 characters");

                      return null;
                    },
                    decoration: new InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        )),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    onEditingComplete: _signInWithEmailAndPassword,
                    textInputAction: TextInputAction.done,
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        MaterialButton(
                            onPressed:(){
                                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotScreen()),
                            );
                            }, child: Text("Forgot Password ?")),
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: _signInWithEmailAndPassword,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
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
      _formTF()
    ])));
  }
}
