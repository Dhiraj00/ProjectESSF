import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsTile extends StatelessWidget {
  final String title, subtitle, description;
  final DateTime date;
  final String imageUrl;
  final String phone;
  
  final String lat;
  final String lng;

  EventsTile(
      {@required this.title,
      @required this.subtitle,
      @required this.date,
      this.lat,
      this.lng,
      @required this.description,
      @required this.imageUrl, this.phone});

  @override
  Widget build(BuildContext context) {
     void _launchDirectionUrl(String lat, String lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }}
      void _launchCalls(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  
  }
    return Card(
        child: Container(
          color: Colors.blue[100],
            child: Column(
      children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              DateFormat.yMMMMEEEEd().format(date),
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
         SizedBox(height: 8.0),
      
         Row(
           mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
          children: [
             new IconButton(icon: Icon(Icons.phone), onPressed: () {_launchCalls(phone);}),
            
             InkWell(
               
          splashColor: Colors.blue,
          child: SizedBox(
            height: 300,
            width: 250,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: (imageUrl != null) ? Image.network(imageUrl,height: 200, width: 3001,) : null),
          ),
        ),
        
        new IconButton(icon: Icon(Icons.directions), onPressed: () {_launchDirectionUrl(lat,lng);}),
          ],
        ),
       
        SizedBox(height: 8.0),
        Text(title,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
        SizedBox(height: 8.0),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
        ),
       
        Padding(
          padding: const EdgeInsets.only(left:15.0, right: 15.0, top:4,bottom: 2),
          child: Text(
            description,
            style: TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(height: 8.0),
       
      ],
    )));
  }
}
