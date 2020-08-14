




import 'package:essf/LandingPage.dart';
import 'package:essf/auth.dart';
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
       // as we say we have home named as login page
      theme: new ThemeData(
          //chnage the theme for loginpage
          primarySwatch:
              Colors.blue //primary swatch helps to give the perfect color
          ),
      home: LandingPage(
          auth: Auth(),
    ));
  }
}

