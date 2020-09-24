
import 'package:essf/LoginPage.dart';
import 'package:essf/Platformecxception.dart';
import 'package:essf/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Admin extends StatefulWidget {
  const Admin({Key key, this.auth}) : super(key: key);

  final AuthBase auth;
  @override
  _AdminState createState() => _AdminState(auth: Auth());
}

class _AdminState extends State<Admin> {
  _AdminState({
    @required this.auth,
  });
  AuthBase auth;
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 
  final FocusNode _passwordFocusNode = FocusNode();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  @override
  void initState() {
    auth = Auth();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in Failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      if (_formKey.currentState.validate()) _formKey.currentState.save();
      await auth.signInWithEmailAndPassword(context, _email, _password);
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
                        onEditingComplete: () async {
                          _signInWithEmailAndPassword(context);
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 20.0),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () =>
                                _signInWithEmailAndPassword(context),
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
            onPressed: () {
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
