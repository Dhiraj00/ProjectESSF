import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formkey = new GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String get _title => _titleController.text;
  String get _subtitle => _subtitleController.text;
  String get _description => _descriptionController.text;
  void dispose(){
    super.dispose();
    _titleController.clear();
    _subtitleController.clear();
    _descriptionController.clear();

  }

  Widget _form() {
    return Form(
      key: _formkey,
      autovalidate: true,
      child: Container(
          padding: const EdgeInsets.all(10),
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
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
                      left: 15, right: 15, top: 10, bottom: 10),
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
                      left: 15, right: 15, top: 40, bottom: 60),
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: Colors.white),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(4.0))),
                  child: new TextFormField(
                    controller: _descriptionController,
                    validator: (String _description) {
                      if (_description.isEmpty) {
                        return ("Description needed");
                      } else if (_description.length < 50) {
                        return ("Description count has to be atleast 50 words");
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
              ])),
    );
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
      child: Column(mainAxisSize: MainAxisSize.min, children: [_form()]),
    ));
  }
}
