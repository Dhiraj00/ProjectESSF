import 'package:essf/servicecategories/models/helpline.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class AlcoholandDrugs extends StatefulWidget {
  @override
  _AlcoholandDrugsState createState() => _AlcoholandDrugsState();
}

class _AlcoholandDrugsState extends State<AlcoholandDrugs> {
  bool descTextShowFlag = false;
  final String desc2 =
      'Reaching out for help and support is an important first step in dealing with the issues drugs and alcohol might be causing in your life, or affecting a friend or family member.Here you will find a number of different resources to help you, or help you support someone you care about.';
  final String desc1 =
      'There are services throughout Australia that offer drug and/or alcohol support and treatment options for yourself or people you care about.Different people will have different service needs, and this will depend on the nature and complexity of the issues they might be facing.  In many cases, starting a conversation with your local doctor or primary care provider can be a good first step.You may also wish to call the National Alcohol and Other Drug Hotline on 1800 250 015. The Hotline will automatically connect you to the Alcohol and Drug Information Service operating in your state/territory. Free and confidential advice is available and professionals can assist with connecting you to the most appropriate services for your needs.Another option you might want to consider is online support and help through Counselling Online.';
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
                    new AssetImage("lib/servicecategories/assets/alcohol2.jpeg"),
                    fit: BoxFit.fitWidth,
                height: 200.0,
                width: 350.0,
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
              child: Text(' "Alcohol & Drugs Care Services" ',
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
                      "lib/servicecategories/assets/alcohol1.jpg"), fit: BoxFit.fitWidth,
                height: 200.0,
                width: 350.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(' "Alcohol & Drugs" ',
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
                        'aihw.gov.au/reports/alcohol-other-drug-treatment-services/aodts-state-territory-summaries/contents/summary');
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
                      "https://www2.health.vic.gov.au/alcohol-and-drugs/aod-treatment-services");
                },
                label: Text('Start the Services finder here'),
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
                _launchCalls('https://www.mhc.wa.gov.au/about-us/our-services/alcohol-and-drug-support-service/');
              },
              child: new Column(children: <Widget>[
                SizedBox(height: 5.0),
                Text(
                  'Alcohol and Drugs Support Services',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10.0),
                Image.asset(
                  'lib/servicecategories/assets/alcohol3.jpg',
                  fit: BoxFit.fill,
                  height: 59,
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
                    'https://www.rehabmelbourne.com.au/');
              },
              child: new Column(children: <Widget>[
                SizedBox(height: 5.0),
                Text(
                  'Find a rehabilitation center',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 0.0),
                Image.asset(
                  'lib/servicecategories/assets/rehab.png',
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
                onPressed: () => _launchCalls(
                    "https://www2.health.vic.gov.au/alcohol-and-drugs"),
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
          "Alcohol and Drugs",
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
      SizedBox(height: 5.0),
      _description(),
      SizedBox(height: 5.0),
      _container2(),
      SizedBox(height: 5.0),
      _description2(),
      SizedBox(height: 5.0),
      _helpline(),
      SizedBox(height: 5.0),
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
