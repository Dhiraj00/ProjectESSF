import 'package:essf/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class HomePage extends StatelessWidget {
  HomePage({
    @required this.auth,
  });

  final AuthBase auth;
  Future<void> _signOut() async {
    try {
      await auth.signout();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: new Center(
              child: new Text(
            'ESSF',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.yellow,
            ),
            textAlign: TextAlign.end,
          )),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: _signOut,
              icon: Icon(Icons.lock),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ))
          ]),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          Container(
            height: 200,
            child: DrawerHeader(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.black,
                    child: ClipOval(
                      child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: Image.asset("assets/Givemeshelter.png"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 0.0, right: 0.9, top: 50.0),
                    child: IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: () {},
                      iconSize: 30.0,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Dhiraj Chaudhary',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[Colors.blueAccent, Colors.blueAccent],
              )),
            ),
          ),
          SizedBox(height: 15.0),
          CustomListTile(icon: Icons.home, text: 'Home', onTap: () => {}),
          SizedBox(height: 15.0),
          CustomListTile(icon: Icons.help, text: 'Services', onTap: () => {}),
          SizedBox(height: 15.0),
          CustomListTile(icon: Icons.event, text: 'Events', onTap: () => {}),
          SizedBox(height: 15.0),
          CustomListTile(
              icon: Icons.notifications, text: 'Notification', onTap: () => {}),
          SizedBox(height: 15.0),
          CustomListTile(icon: Icons.phone, text: 'Emergency', onTap: () => {}),
          SizedBox(height: 15.0),
          CustomListTile(
              icon: Icons.settings, text: 'Settings', onTap: () => {}),
        ],
      )),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile({@required this.icon, this.text, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.blueAccent,
            child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            text,
                            style: TextStyle(fontSize: 17.0),
                          ),
                        )
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ]),
            ),
          ),
        ));
  }
}
