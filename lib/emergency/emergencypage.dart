import 'package:essf/Homepage.dart';

import 'package:essf/emergency/emergency.dart';
import 'package:essf/models/EmergencyModel.dart';
import 'package:flutter/material.dart';

class EmergencyContacts extends StatefulWidget {
  @override
  _EmergencyContactsState createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  List<View> _emergencyModel;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Emergencies.getData().then((emergencyModel) {
      setState(() {
        _emergencyModel = emergencyModel;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading....' : 'Emergencies'),
        elevation: 0.0,
         backgroundColor: Colors.blueAccent,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        auth: null,
                      ))),
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount:_emergencyModel.length,
            itemBuilder: (context, index) {
              View emergency = _emergencyModel[index];
              return ListTile(
                title: Text(emergency.name),
                
              );
            }),
      ),
    );
  }
}
