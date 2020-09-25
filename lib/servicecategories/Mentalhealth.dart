import 'package:essf/servicecategories/models/helpline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MentalHealth extends StatefulWidget {
  @override
  _MentalHealthState createState() => _MentalHealthState();
}

class _MentalHealthState extends State<MentalHealth> {
   bool descTextShowFlag = false;
  final String desc1='During the COVID-19 pandemic, prioritising mental health and wellbeing has been more important than ever. This World Mental Health Day – October 10 – the message is simple: “Look after your mental health, Australia.';
  final String desc2='If you or someone you care for is in need of immediate assistance you can contact the below National 24/7 Crisis Counselling Services';
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
                    "lib/servicecategories/assets/mentalhealth.jpg"),
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
              child: Text(' "Look after your Mental Health" ',
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      color: Colors.yellow,
                      fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 10.0),
              child: Center(
                child: Text(
                    '1 in 5 Australians are affected by mental illness annually, yet many don\'t seek help because of stigma.',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Colors.white)),
              ),
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
    return Column(
        // inorder to make the logo stay in centre
        children: <Widget>[
          new Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: new Image(
                image: new AssetImage("lib/servicecategories/assets/logo.png"),
                height: 150.0,
                width: 400.0,
              ),
            ),
          ),
          new Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: new Image(
                image: new AssetImage("lib/servicecategories/assets/help.png"),
                height: 150.0,
                width: 400.0,
              ),
            ),
          )
        ]);
  }

  Widget _description2() {
    return Padding(
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
              ));
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
          children:<Widget> [
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
             Title(color: Colors.cyan, child:  Text('Visit More Information here',style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.red[50])),),IconButton(icon:Icon( Icons.open_in_browser), onPressed: ()=> _launchCalls("https://www.headtohealth.gov.au/"), iconSize: 50,)
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
          "Mental Health",
          style:
              GoogleFonts.arbutus(fontSize: 20.0, color: Colors.yellowAccent),
          textAlign: TextAlign.end,
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
      _container2(),
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
