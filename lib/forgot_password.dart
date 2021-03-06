import 'package:essf/LoginPage.dart';
import 'package:essf/Platformecxception.dart';
import 'package:essf/auth.dart';
import 'package:essf/platform_alert.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotScreen extends StatefulWidget {
  ForgotScreen({this.auth});
  final AuthBase auth;
  @override
  _ForgotScreenState createState() => _ForgotScreenState(auth: auth);
}

class _ForgotScreenState extends State<ForgotScreen> {
  _ForgotScreenState({@required this.auth});
  AuthBase auth;

  final _formKey = new GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String get _email => _emailController.text;

  @override
  void initState() {
  auth=Auth();
    super.initState();
  }
  void dispose(){
    super.dispose();
  }
  

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Error',
      exception: exception,
    ).show(context);
  }
  

  Future<void> _resetPassword(BuildContext context, email) async {
    if (_formKey.currentState.validate()) _formKey.currentState.save();

    try {
      await auth.sendPasswordResetEmail(_email);
     
        Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => LogInPage(),
            ));
      

      PlatformAlertDialog(
              title: "Reset password",
              content:
                  'Please check your email to change your password. If only an account exist with this email,You\'ll be able to change the password',
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
            alignment: Alignment.topCenter,
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

  Widget _textFormField() {
    return Form(
        key: _formKey,
        autovalidate: true,
        child: Theme(
            data: new ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
            ),
            child: Container(
                padding: const EdgeInsets.all(100.0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new TextFormField(
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
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 20.0),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => _resetPassword(context, _email),
                            child: Text("Submit"),
                            color: Colors.blueGrey,
                            padding: EdgeInsets.only(
                                left: 60.5, right: 60.5, top: 12, bottom: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          )
                        ],
                      )
                    ]))));
  }

  Widget _goback() {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: ()  { 
             
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInPage(),
                  ));
            },
            child: Icon(Icons.arrow_back_ios),
            color: Colors.lightBlue,
            padding: EdgeInsets.only(left: 3.5, right: 3.5, top: 7, bottom: 7),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: _body(),
    );
  }

  _body() {
    return Center(
        child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
      _companyLogo(),
      SizedBox(height: 0.0),
      _nameTF(),
      _textFormField(),
      _goback(),
    ])));
  }
}
