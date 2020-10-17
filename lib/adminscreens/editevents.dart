import 'package:essf/events/eventslisttile.dart';
import 'package:essf/firestore/Firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditEventsPage extends StatefulWidget {
  @override
  _EditEventsPageState createState() => _EditEventsPageState();
}

class _EditEventsPageState extends State<EditEventsPage> {
  TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
 
  TextEditingController _phoneController = TextEditingController();
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
              return GestureDetector(
                onTap: () {
                  openDialogueBox(
                    context,
                    eventsList[index]['title'],
                  );
                },
                child: EventsTile(
                    title: eventsList[index]['title'],
                    subtitle: eventsList[index]['subtitle'],
                    description: eventsList[index]['description'],
                    date: eventsList[index]['date'].toDate(),
                    imageUrl: eventsList[index]['image'],
                    lat: eventsList[index]['lat'],
                    lng: eventsList[index]['lng'],
                    phone: eventsList[index]['phone']),
              );
            }),
      ),
    );
  }

  openDialogueBox(
    BuildContext context,
    String title,
  ) {
    _titleController.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Event details'),
            content: Container(
                height: 200,
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(hintText: 'Title'),
                    ),
                    TextField(
                      controller: _subtitleController,
                      decoration: InputDecoration(hintText: 'Subtitle'),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(hintText: 'description'),
                    ),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(hintText: 'phone'),
                    ),
                  ],
                )),
            actions: [
              FlatButton(
                  onPressed: () {
                    DatabaseManager().updateEventsList(
                      _titleController.text,
                      _subtitleController.text,
                      _phoneController.text,
                      _descriptionController.text,
                    );
                  },
                  child: Text('Submit')),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }
}
