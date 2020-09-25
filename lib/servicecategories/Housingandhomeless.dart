import 'package:essf/servicecategories/models/helpline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HousingandHomelessness extends StatefulWidget {
  @override
  _HousingandHomelessnessState createState() => _HousingandHomelessnessState();
}

class _HousingandHomelessnessState extends State<HousingandHomelessness> {
    bool descTextShowFlag = false;
  final String desc2='Every night more than 116,000 people in Australia are homeless1 as a result of many complex factors including unemployment, mental health issues, substance misuse or the loss of a job or loved one. Homelessness is a problem that goes beyond not having access to safe shelter as it can wreak havoc on a person’s health, keep them out of work and leave them socially isolated.Across the nation, the extent of the problem is hidden as most people experiencing homelessness aren’t sleeping rough on the streets. Couch surfing, living in overcrowded and inadequate dwellings, sleeping in the car or relying on short-term accommodation can all be considered forms of homelessness. Learn more about homelessness';
  final String desc1= 'Access to safe and secure housing is an integral part of independence and connection within a community. At Goget Shelter,we believe every person across the country should have access to safe and secure housing. In Australia however, the shortage of affordable housing and high rental costs means disadvantaged people are increasingly vulnerable to homelessness.';
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
                image:
                    new AssetImage("lib/servicecategories/assets/housing.jpg"),
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
        child: Column(
          children: <Widget>[
            Center(
              child: Text(' "Homelessness and Social Housing" ',
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
          ],
        ));
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
              child: Text(' "Homelessness in Australia" ',
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
                  Text(desc2,
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
                    _launchCalls(
                        'https://www.missionaustralia.com.au/what-we-do/homelessness-social-housing/what-is-homelessness');
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
                      "https://optionsfinder.housing.vic.gov.au/#/page/1");
                },
                label: Text('Start the Housing Options Finder'),
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
        child: Text(
           'If you or someone you care for is in need of immediate assistance you can contact the below National 24/7 Crisis Counselling Services',
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
              onPressed: () {      _launchCalls('https://www.housing.vic.gov.au/online-services');},
              child: new Column(children: <Widget>[
                SizedBox(height:5.0),
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
              onPressed: () {_launchCalls('https://www.housing.vic.gov.au/housing-options');},
              child: new Column(children: <Widget>[
                SizedBox(height:5.0),
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
              onPressed: () {_launchCalls('https://www.housing.vic.gov.au/rentassist-bond-loan');},
              child: new Column(children: <Widget>[
                SizedBox(height:5.0),
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
              .loadString('lib/servicecategories/json_contacts/contacts.json'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Helpline> helplines =
                  helplineFromJson(snapshot.data.toString());

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
                        itemCount: helplines.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              color: Color.fromRGBO(130, 90, 255, 1),
                              child: ListTile(
                                  title: Text(
                                    helplines[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  leading: IconButton(
                                    icon: Icon(Icons.call),
                                    onPressed: () {
                                      (helplines[index].phone != null)
                                          ? _launchCalls(
                                              'tel:+61 ${helplines[index].phone}')
                                          : _launchCalls(null);
                                    },
                                    color: Colors.blueAccent,
                                  )));
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
                onPressed: () =>
                    _launchCalls("https://www.dhhs.vic.gov.au/housing-and-homelessness-coronavirus-covid-19"),
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
          "Housing and Homelessnes",
          style:
              GoogleFonts.arbutus(fontSize: 16.0, color: Colors.yellowAccent),
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
      _buttons(),
      SizedBox(height: 10.0),
      _container1(),
      SizedBox(height: 10.0),
      _description(),
      SizedBox(height: 15.0),
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
