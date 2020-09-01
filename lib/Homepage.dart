import 'dart:io';
import 'package:essf/Drawerpages/Customlisttile.dart';
import 'package:essf/Drawerpages/services.dart';
import 'package:essf/News/news.dart';
import 'package:essf/auth.dart';
import 'package:essf/emergency/emergencypage.dart';
import 'package:essf/maps/Servicesnearme.dart';
import 'package:essf/models/articlemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.auth});

  final AuthBase auth;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ArticleModel> articles = new List<ArticleModel>();
  List<Services> services = Services.serviceItems();
  List<DropdownMenuItem<Services>> _dropdownMenuItems;
  bool _loading;

  @override
  void initState() {
    _loading = true;
    _dropdownMenuItems = buildDropdownMenuItems(services);

    super.initState();

    _loadCurrentUser();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  List<DropdownMenuItem<Services>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Services>> items = List();
    for (Services category in services) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: Text(
            category.services,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Services selectedServices) {
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
        // call setState to rebuild the view
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

  Future<void> _signOut() async {
    try {
      await widget.auth.signout();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Future getImage(ImageSource source, {BuildContext context}) async {
      try {
        final pickedFile = await picker.getImage(source: source);
        if (pickedFile != null) {
          setState(() {
            _image = pickedFile as File;

            print('Image path $_image');
          });
        }
      } catch (e) {
        print(e.toString());
      }
    }

    Future<void> _showPickOptionsDialog(BuildContext context) async {
      return Platform.isIOS
          ? await showCupertinoDialog(
              context: context,
              builder: (context) => AlertDialog(
                      content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                        title: Text('Pick image from your gallery'),
                      ),
                      ListTile(
                        onTap: () {
                          getImage(ImageSource.camera);
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
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Text('Pick image from your gallery'),
                      ),
                      ListTile(
                        onTap: () {
                          getImage(ImageSource.camera);
                        },
                        title: Text('Capture photo'),
                      )
                    ],
                  )));
    }

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
                onPressed: () {
                  Navigator.pushReplacement(
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
                                  : Image.file(_image),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 160, top: 60),
                        child: FlatButton(
                          onPressed: () {
                            _showPickOptionsDialog(context);
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
            CustomListTile(icon: Icons.home, text: 'Home', onTap: () => {}),
            SizedBox(height: 15.0),
            CustomListTile(
                icon: Icons.near_me,
                text: 'Services Nearby',
                onTap: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServicesNearMe())),
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
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => EmergencyContacts())),
            ),
            SizedBox(height: 15.0),
            CustomListTile(
                icon: Icons.rate_review, text: 'Rate the App', onTap: () => {}),
            SizedBox(height: 15.0),
            CustomListTile(
                icon: Icons.lock, text: 'Logout', onTap: _signOut,)
          ],
        )),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 134,
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: buildDropdownButton(),
                      ),
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
                            url: articles[index].url,
                          );
                        },
                      )),
                    )
            ],
          ),
        )));
  }

  DropdownButton<Services> buildDropdownButton() {
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
        items: _dropdownMenuItems,
        onChanged: onChangeDropdownItem);
  }
}
