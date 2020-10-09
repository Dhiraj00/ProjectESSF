
import 'package:essf/adminscreens/addeventpage.dart';



import 'package:essf/adminscreens/appusers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Size screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: new AppBar(
        title: new Text("Administrator"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0.0,
      ),
      //drawer: new Drawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 20.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/homepage');
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.home),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Homepage"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(
              height: 20.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => AppUsers()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.person),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("App Users"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => AddEvent()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.event),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Add Events"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(
              height: 20.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                   
                     Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.lock),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Logout"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
