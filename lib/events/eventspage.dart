import 'package:essf/events/eventslisttile.dart';
import 'package:essf/firestore/Firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List eventsList = [];
  String eventtID = "";
  @override
  void initState() {
    super.initState();

    fetchdatabaseList();
  }

  fetchdatabaseList() async {
    dynamic resultant = await DatabaseManager().getEventsList();
    if (resultant == null) {
      print('unnable to retrieve');
    } else {
      setState(() {
        eventsList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/homepage');
            }),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: eventsList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return EventsTile(
                title: eventsList[index]['title'],
                subtitle: eventsList[index]['subtitle'],
                description: eventsList[index]['description'],
                date: eventsList[index]['date'].toDate(),
                imageUrl: eventsList[index]['image'],
                lat: eventsList[index]['lat'],
                lng: eventsList[index]['lng'],
                phone:eventsList[index]['phone']
              );
            }),
      ),
    );
  }
}
