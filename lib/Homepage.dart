import 'dart:io';
import 'package:essf/Drawerpages/Customlisttile.dart';
import 'package:essf/Drawerpages/services.dart';

import 'package:essf/News/news.dart';


import 'package:essf/auth.dart';
import 'package:essf/emergency/emergencypage.dart';
import 'package:essf/firestore/Firestore.dart';
import 'package:essf/maps/Servicesnearme.dart';
import 'package:essf/models/articlemodel.dart';
import 'package:essf/platform_alert.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.auth});

  final AuthBase auth;

  @override
  _HomePageState createState() => _HomePageState(auth: auth);
}

class _HomePageState extends State<HomePage> {
  
  _HomePageState({@required this.auth});

 
  List<ArticleModel> articles = new List<ArticleModel>();
  List<Services> services = Services.serviceItems();

  bool _loading;

  AuthBase auth;
   UserManagement userObj = new UserManagement();

  @override
  void initState() {
    _loading = true;
    //_dropdownMenuItems = buildDropdownMenuItems(services);

    super.initState();
    _loadCurrentUser();
    _email();

    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    if (this.mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  List<DropdownMenuItem<Services>> buildDropdownMenuItems(
      List companies, BuildContext context) {
    List<DropdownMenuItem<Services>> items = List();
    for (Services category in services) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: GestureDetector(
            onTap: () => category.onPressed(context),
            child: Text(
              category.services,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem() {
    setState(() {});
  }

  File _image;

  final ImagePicker picker = ImagePicker();

  FirebaseUser currentUser;
  final Future<String> userEmail = FirebaseAuth.instance
      .currentUser()
      .then((FirebaseUser user) => user.email);
  var e = "";

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  String _email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "no current user";
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await widget.auth.signout();
      Navigator.pushReplacementNamed(context, '/login');
    } on PlatformException catch (e) {
      return print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context, {listen = false}) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut != false) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future getImage(ImageSource source, {BuildContext context}) async {
      try {
        final pickedFile = await picker.getImage(source: source);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
            print('Image path $_image');
          });
        }
      } catch (e) {
        print(e.toString());
      }
    }

    Future _uploadPic(BuildContext context) async {
      String filename = basename(_image.path);
      StorageReference firebasestorageref =
          FirebaseStorage.instance.ref().child(filename);
      StorageUploadTask uploadTask = firebasestorageref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print("profile picture uploaded");
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Profile Picture Uploaded"),
        ));
      });
    }

    Future<void> _showPickOptionsDialog(BuildContext context) async {
      return (Platform.isIOS != false)
          ? await showCupertinoDialog(
              context: context,
              builder: (context) => AlertDialog(
                      content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        onTap: () async {
                          await getImage(ImageSource.gallery);
                          _uploadPic(context);
                          Navigator.pop(context);
                        },
                        title: Text('Pick image from your gallery'),
                      ),
                      ListTile(
                        onTap: () async {
                          await getImage(ImageSource.camera);
                          _uploadPic(context);
                          Navigator.pop(context);
                        },
                        title: Text('Capture photo'),
                      )
                    ],
                  )))
          : await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                      content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          await getImage(ImageSource.gallery);
                          _uploadPic(context);
                          Navigator.pop(context);
                        },
                        child: Text('Pick image from your gallery'),
                      ),
                      ListTile(
                        onTap: () async {
                          await getImage(ImageSource.camera);
                          _uploadPic(context);
                          Navigator.pop(context);
                        },
                        title: Text('Capture photo'),
                      )
                    ],
                  )));
    }

    void _launchUrl(url) async {
      url = "https://givemeshelterenterprise.org/";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'could not launch $url';
      }
    }

    return Scaffold(
        appBar: AppBar(
            title: new Center(
                child: new Text(
              'ESSF',
              style: GoogleFonts.arbutus(
                  fontSize: 27.0, color: Colors.yellowAccent),
              textAlign: TextAlign.end,
            )),
            backgroundColor: Colors.blueAccent,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServicesNearMe()));
                },
                icon: Icon(Icons.near_me),
              ),
            ]),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              child: DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Center(
                        child: new CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.black,
                          child: ClipOval(
                            child: SizedBox(
                              width: 100.0,
                              height: 100.0,
                              child: _image == null
                                  ? Image.asset("assets/Givemeshelter.png")
                                  : Image.file(_image, fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 160, top: 60),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              _showPickOptionsDialog(context);
                            });
                          },
                          child: Icon(Icons.add_a_photo),
                        ),
                      ),
                    ]),
                    SizedBox(height: 10.0),
                    Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              _email(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13.0,
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
            CustomListTile(
                icon: Icons.home,
                text: 'Home',
                onTap: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                auth: Auth(),
                              )));
                }),
            SizedBox(height: 15.0),
            CustomListTile(
                icon: Icons.near_me,
                text: 'Services Nearby',
                onTap: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServicesNearMe()));
                }),
            SizedBox(height: 15.0),
            CustomListTile(icon: Icons.event, text: 'Events', onTap: () => {}),
            SizedBox(height: 15.0),
            CustomListTile(
                icon: Icons.notifications,
                text: 'Notification',
                onTap: () => {}),
            SizedBox(height: 15.0),
            CustomListTile(
                icon: Icons.phone,
                text: 'Emergency',
                onTap: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmergencyContacts()));
                }),
            SizedBox(height: 15.0),
            
            CustomListTile(
                icon: Icons.dashboard,
                text: 'Admin Page',
                onTap: () {
                      
                  userObj.authorizeAdmin(context);
                    }),
            SizedBox(height: 15.0),
            CustomListTile(
              icon: Icons.lock,
              text: 'Logout',
              onTap: () async {
                _confirmSignOut(context);
              },
            )
          ],
        )),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 250,
                  margin: const EdgeInsets.all(7.0),
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Color.fromRGBO(130, 90, 255, 1)),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Text('Find a Service',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.4)),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: buildDropdownButton(context),
                        ),
                        Image(
                          image: new AssetImage("assets/Givemeshelter.png"),
                          height: 60.0,
                          width: 140.0,
                          colorBlendMode: BlendMode.darken,
                        ),
                        Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              width: 250.0,
                              height: 100.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Creating homes, jobs and rehabilitation for the homeless before they hit the streets",
                                    style: GoogleFonts.yantramanav(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 260.0, top: 10.0),
                            child: RaisedButton(
                                color: Colors.black45,
                                splashColor: Colors.blue,
                                onPressed: () => _launchUrl(url),
                                child: RichText(
                                    text: new TextSpan(
                                        style: new TextStyle(
                                          fontSize: 18.0,
                                        ),
                                        children: [
                                      new TextSpan(
                                        text: 'Visit',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      new TextSpan(
                                          text: 'Here',
                                          style: TextStyle(
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.bold))
                                    ]))),
                          )
                        ])
                      ]),
                    ),
                  ])),
              SizedBox(height: 9.0),
              _loading
                  ? Center(
                      child: Container(
                      child: CircularProgressIndicator(),
                    ))
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                          child: ListView.builder(
                        itemCount: articles.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url);
                        },
                      )),
                    )
            ],
          ),
        )));
  }

  DropdownButton<Services> buildDropdownButton(BuildContext context) {
    return DropdownButton(
      dropdownColor: Color.fromRGBO(130, 90, 255, 1),
      focusColor: Colors.black,
      isDense: true,
      iconSize: 40,
      elevation: 16,
      hint: Center(
        child: Text(
          'Services Directory',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      isExpanded: true,
      items: buildDropdownMenuItems(services, context),
      onChanged: (Services value) {},
    );
  }
}
