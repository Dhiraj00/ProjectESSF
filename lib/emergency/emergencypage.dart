
import 'package:essf/auth.dart';
import 'package:essf/emergency/contact.dart';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';


class EmergencyContacts extends StatefulWidget {
  final AuthBase auth;

  const EmergencyContacts({ this.auth}) ;
  @override
  _EmergencyContactsState createState() => _EmergencyContactsState(auth: auth);
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  _EmergencyContactsState({@required this.auth});
  AuthBase auth;


  
  void initState() {
     auth = Auth();

    super.initState();
   
   
   
  }

  List data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text(
              'Emergency',
              textAlign: TextAlign.center,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/homepage');
              
            },
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                {}
              },
              icon: Icon(Icons.notifications),
            ),
          ]),
      body: Container(
          color: Colors.white10,
          child: Center(
            child: new FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('launch_json/contact.json'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Contact> contacts =
                        contactFromJson(snapshot.data.toString());

                    return new ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
                            child: new Card(
                              child: ListTile(
                                title: Text(
                                  contacts[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                subtitle: (contacts[index].address != null)
                                    ? Text(
                                        contacts[index].address,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal,
                                        ),
                                        textAlign: TextAlign.start,
                                      )
                                    : [],
                                leading: IconButton(
                                  icon: Icon(Icons.call),
                                  onPressed: () {
                                    (contacts[index].phone != null)
                                        ? _launchCalls(
                                            'tel:+61 ${contacts[index].phone}')
                                        : _launchCalls(null);
                                  },
                                  color: Colors.blueAccent,
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.directions),
                                  onPressed: () {
                                    (contacts[index].phone != null)
                                        ? _launchDirectionUrl(
                                            contacts[index].location.lat,
                                            contacts[index].location.lng)
                                        : _launchDirectionUrl(null, null);
                                  },
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  return CircularProgressIndicator();
                }),
          )),
    );
  }

  void _launchDirectionUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }

  void _launchCalls(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }
}
