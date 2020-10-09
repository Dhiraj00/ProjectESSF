import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:essf/firestore/Firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formkey = new GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  String get _title => _titleController.text;
  double  _lat ;
 double _lng;

  String get _phone => _phoneController.text;

  String get _subtitle => _subtitleController.text;
  String get _description => _descriptionController.text;

  DateTime selectedDate = DateTime.now();
  bool dateSelected = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        dateSelected = true;
        selectedDate = picked;
      });
  }

  void dispose() {
    super.dispose();
    _titleController.clear();
    _subtitleController.clear();
    _descriptionController.clear();
    _phoneController.clear();
    _latController.clear();
    _lngController.clear();
  }

  void initState() {
    super.initState();
  }

  String image;
  File _image;
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource source, {BuildContext context}) async {
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
    final String imageUrl = (await taskSnapshot.ref.getDownloadURL());
    image = imageUrl;
    print('URL Is $imageUrl');
    setState(() {
      print("profile picture uploaded");
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Profile Picture Uploaded"),
      ));
    });
  }

  Future<void> showPickOptionsDialog(BuildContext context) async {
    return await showCupertinoDialog(
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
            )));
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: Text('Add Events'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.fullscreen_exit),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: _body());
  }

  _body() {
    return new Container(
        child: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Form(
          key: _formkey,
          autovalidate: true,
          child: Container(
              padding: const EdgeInsets.all(10),
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(color: Colors.white),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(4.0))),
                      child: new TextFormField(
                        controller: _titleController,
                        validator: (String _title) {
                          if (_title.isEmpty) {
                            return ("Title required");
                          } else if (_title.length < 10) {
                            return ("Title should have atleast 10 words");
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add Title",
                            focusColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(color: Colors.white),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(4.0))),
                      child: new TextFormField(
                        controller: _subtitleController,
                        validator: (String _subtitle) {
                          if (_subtitle.isEmpty) {
                            return ("Subtitle required");
                          } else if (_subtitle.length < 10) {
                            return ("Subtitle should have atleast 10 words");
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add Subtitle",
                            focusColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(color: Colors.white),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(4.0))),
                      child: new TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        validator: (String _phone) {
                          if (_phone.isEmpty) {
                            return ("Phone required");
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add Phone",
                            focusColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    
                    Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(color: Colors.white),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(4.0))),
                      child: new TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _latController,
                        validator: (String _lat) {
                          if (_lat.isEmpty) {
                            return ("latitude required");
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add latitude for direction",
                            focusColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                     Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(color: Colors.white),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(4.0))),
                      child: new TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _lngController,
                        validator: (String _long) {
                          if (_long.isEmpty) {
                            return ("longitude required");
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add longitude for direction",
                            focusColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    
                    Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(color: Colors.white),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(4.0))),
                      child: new TextFormField(
                        controller: _descriptionController,
                        validator: (String _description) {
                          if (_description.isEmpty) {
                            return ("Description Required");
                          } else if (_description.length < 25) {
                            return ("Description count has to be atleast 20 words");
                          }

                          return null;
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add Description",
                            focusColor: Colors.white),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    new Center(
                        child: Container(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                border: new Border.all(color: Colors.cyan),
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(8.0))),
                            height: 150,
                            width: 200,
                            child: _image == null
                                ? Image.asset("assets/Givemeshelter.png", fit: BoxFit.fill,)
                                : Image.file(_image,fit: BoxFit.fill,))),
                    new Center(
                        child: RaisedButton.icon(
                            padding: EdgeInsets.only(left: 44, right: 44),
                            splashColor: Colors.blue,
                            onPressed: () {
                              showPickOptionsDialog(this.context);
                            },
                            icon: Icon(Icons.add_a_photo),
                            label: Text('upload photo'))),
                    new Center(
                      child: RaisedButton.icon(
                        padding: EdgeInsets.only(left: 51, right: 51),
                        icon: Icon(Icons.schedule),
                        onPressed: () => _selectDate(this.context),
                        label: Text('Select date'),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    new Center(
                        child: RaisedButton.icon(
                            color: Colors.blue,
                            padding: EdgeInsets.only(left: 65, right: 65),
                            splashColor: Colors.blue,
                            onPressed: () {
                              if (!dateSelected) {
                                return;
                              }
                              _submit(_title, _subtitle,_phone,_lat,_lng, _description,
                                  selectedDate);
                            },
                            icon: Icon(Icons.send),
                            label: Text('Submit'))),
                  ])),
        )
      ]),
    ));
  }

  void _submit(title, subtitle, phone, lat,long, description, selectedDate) async {
    if (_formkey.currentState.validate()) _formkey.currentState.save();
    await DatabaseManager().createEvents(_title,_subtitle,_phone, _lat, _lng,
        _description, selectedDate, image);
    Navigator.pop(this.context);
  }
}
