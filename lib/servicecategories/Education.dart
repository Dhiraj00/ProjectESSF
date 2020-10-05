import 'package:essf/servicecategories/models/educationalmodel.dart';

import 'package:flutter/material.dart';


import 'package:url_launcher/url_launcher.dart';

class Education extends StatefulWidget {
  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  bool descTextShowFlag = false;
  final String desc3 =
      'GiveMe Shelter has been classified as an essential community service and remains open during stage 4 restrictions in Victoria.If you are at risk of, or experiencing homelessness please call 1800 825 955 to speak to a housing support worker for adviceAnyone who is able to should contact homelessness services via phone rather than attending in person to minimise the risk of transmission.Still, if you need to go to a homelessness access point our Collingwood, St Kilda and Cheltenham offices remain open and can provide a crisis response to your immediate accommodation needs and connect you to other support services.';
  final String desc1 =
      "Every night more than 116,000 people in Australia are homeless1 as a result of many complex factors including unemployment, mental health issues, substance misuse or the loss of a job or loved one. Homelessness is a problem that goes beyond not having access to safe shelter as it can wreak havoc on a person’s health, keep them out of work and leave them socially isolated.Across the nation, the extent of the problem is hidden as most people experiencing homelessness aren’t sleeping rough on the streets. Couch surfing, living in overcrowded and inadequate dwellings, sleeping in the car or relying on short-term accommodation can all be considered forms of homelessness. Learn more about homelessness";
  final String desc2 =
      "If you or someone you care for is in need of immediate assistance you can contact the below National 24/7 Crisis Counselling Services:";
  List data;
  ScrollController _scrollController = ScrollController(keepScrollOffset: true);
  void initState() {
    _scrollController = ScrollController(keepScrollOffset: true);
    super.initState();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _container1() {
    return Column(
        // inorder to make the logo stay in centre
        children: <Widget>[
          new Container(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: new Image(
                image: new AssetImage(
                    "lib/servicecategories/assets/Homelessed.jpg"),
                height: 250.0,
                width: 400.0,
              ),
            ),
          ),
        ]);
  }

  Widget _description() {
    return Container(
        width: 390,
        child: Column(children: <Widget>[
          Center(
            child: Text(' "Education Training and Employment" ',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    color: Colors.yellow,
                    fontSize: 20)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Text(desc1,
                      maxLines: descTextShowFlag ? 18 : 3,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: Colors.white)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        descTextShowFlag = !descTextShowFlag;
                      });
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          descTextShowFlag
                              ? Text(
                                  "Show Less",
                                  style: TextStyle(color: Colors.white70),
                                )
                              : Text(
                                  "Show More",
                                  style: TextStyle(color: Colors.white70),
                                ),
                        ]),
                  )
                ],
              ))
        ]));
  }

  Widget _container2() {
    return Container(
      width: 390,
      child: Column(
          // inorder to make the logo stay in centre
          children: <Widget>[
            new Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: new Image(
                  image: new AssetImage(
                      "lib/servicecategories/assets/housing1.jpg"),
                  height: 250.0,
                  width: 400.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(' "Let\'s end street homelessness" ',
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      color: Colors.yellow,
                      fontSize: 20)),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                child: Column(
                  children: <Widget>[
                    Text(desc3,
                        maxLines: descTextShowFlag ? 18 : 3,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: Colors.white)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          descTextShowFlag = !descTextShowFlag;
                        });
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            descTextShowFlag
                                ? Text(
                                    "Show Less",
                                    style: TextStyle(color: Colors.white70),
                                  )
                                : Text(
                                    "Show More",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                          ]),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 180.0),
              child: RaisedButton(
                  child: Text('Visit here'),
                  color: Color.fromRGBO(130, 90, 255, 1),
                  onPressed: () {
                    _launchCalls('https://givemeshelterenterprise.org/');
                  }),
            ),
            new Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: new Image(
                  image:
                      new AssetImage("lib/servicecategories/assets/help.png"),
                  height: 150.0,
                  width: 400.0,
                ),
              ),
            ),
            Container(
              height: 70.0,
              width: 300.0,
              child: RaisedButton.icon(
                color: Colors.blue,
                onPressed: () {
                  _launchCalls(
                      "https://www.aihw.gov.au/reports/children-youth/australias-children/contents/housing/homelessness");
                },
                label: Text('Check Services Here'),
                icon: Icon(Icons.navigate_next),
              ),
            )
          ]),
    );
  }

  Widget _description2() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, top: 10.0),
      child: Center(
        child: Text(desc2,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Colors.white)),
      ),
    );
  }

  Widget _buttons() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      new Container(
          width: 120,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: RaisedButton(
              color: Colors.purple[50],
              onPressed: () {
                _launchCalls('https://www.housing.vic.gov.au/online-services');
              },
              child: new Column(children: <Widget>[
                SizedBox(height: 5.0),
                Text(
                  'Online Housing Services ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10.0),
                Image.asset(
                  'lib/servicecategories/assets/findhousing.jpg',
                  height: 70,
                  width: 100,
                )
              ]),
            ),
          )),
      SizedBox(width: 10),
      new Container(
          width: 120,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: RaisedButton(
              color: Colors.purple[50],
              onPressed: () {
                _launchCalls('https://www.housing.vic.gov.au/housing-options');
              },
              child: new Column(children: <Widget>[
                SizedBox(height: 5.0),
                Text(
                  'Housing Options Finder ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10.0),
                Image.asset(
                  'lib/servicecategories/assets/optionfinder.png',
                  height: 70,
                  width: 100,
                )
              ]),
            ),
          )),
      SizedBox(width: 10),
      new Container(
          width: 120,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: RaisedButton(
              color: Colors.purple[50],
              onPressed: () {
                _launchCalls(
                    'https://www.housing.vic.gov.au/rentassist-bond-loan');
              },
              child: new Column(children: <Widget>[
                SizedBox(height: 5.0),
                Text(
                  'Find if you can access bond Loan ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 0.0),
                Image.asset(
                  'lib/servicecategories/assets/bond.png',
                  height: 70,
                  width: 100,
                )
              ]),
            ),
          )),
    ]);
  }

  Widget _helpline() {
    return Container(
        child: Center(
      child: new FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('lib/servicecategories/json_contacts/education.json'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Educational> education =
                  educationalFromJson(snapshot.data.toString());

              return Container(
                width: 600,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Scrollbar(
                    controller: _scrollController,
                    isAlwaysShown: true,
                    child: new ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: education.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              color: Color.fromRGBO(130, 90, 255, 1),
                              child: ListTile(
                                title: Text(
                                  education[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                leading: IconButton(
                                  icon: Icon(Icons.call),
                                  onPressed: () {
                                    (education[index].phone != null)
                                        ? _launchCalls(
                                            'tel: ${education[index].phone}')
                                        : _launchCalls(null);
                                  },
                                  color: Colors.blueAccent,
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.web),
                                    onPressed: () {
                                      _launchCalls(education[index].website);
                                    }),
                              ));
                        }),
                  ),
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    ));
  }

  Widget _moreInfo() {
    return Container(
      height: 150,
      child: Center(
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Title(
                color: Colors.cyan,
                child: Text('Visit More Information here',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.red[50])),
              ),
              IconButton(
                icon: Icon(Icons.open_in_browser),
                onPressed: () => _launchCalls("https://www.aihw.gov.au/"),
                iconSize: 50,
              )
            ])
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(130, 90, 255, 1),
      appBar: AppBar(
        title: Center(
            child: Text(
          "Education & Homelessness",
        )),
        backgroundColor: Color.fromRGBO(130, 90, 255, 1),
        elevation: 0.0,
        actions: <Widget>[IconButton(icon: Icon(null), onPressed: null)],
      ),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      _container1(),
      SizedBox(height: 10.0),
      _description(),
      SizedBox(height: 15.0),
      _buttons(),
      SizedBox(height: 10.0),
      _container2(),
      SizedBox(height: 10.0),
      _description2(),
      SizedBox(height: 10.0),
      _helpline(),
      SizedBox(height: 10.0),
      _moreInfo()
    ]));
  }
}

void _launchCalls(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'could not launch $url';
  }
}
