import 'package:essf/Homepage.dart';
import 'package:essf/auth.dart';
import 'package:essf/maps/Geolocatorservice.dart';
import 'package:essf/maps/Places_model.dart';
import 'package:essf/maps/marker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesNearMe extends StatefulWidget {
  const ServicesNearMe({Key key, this.auth}) : super(key: key);

  
  final AuthBase auth;
  @override
  _ServicesNearMeState createState() => _ServicesNearMeState(auth:auth);
}

class _ServicesNearMeState extends State<ServicesNearMe> {
  _ServicesNearMeState({@required this.auth});
 
  AuthBase auth;
  void initState(){
  auth=Auth();
    super.initState();
  
  }
  
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Result>>>(context);
    final geoService = GeolocatorService();
    final markerService = MarkerService();
    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Services Nearby',
                
            )
          ),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
             Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) =>HomePage(auth: Auth(
             ),)));
                
              }),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications), onPressed: () {})
          ],
        ),
        body: (currentPosition != null)
            ? Consumer<List<Result>>(
                builder: (_, places, __) {
                  var markers = (places != null)
                      ? markerService.getMarkers(places)
                      : List<Marker>();
                  return (places != null)
                      ? Column(
                          children: <Widget>[
                            Container(
                                height: MediaQuery.of(context).size.height / 3 +
                                    100,
                                width: MediaQuery.of(context).size.width,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(currentPosition.latitude,
                                          currentPosition.longitude)),
                                  zoomGesturesEnabled: true,
                                  markers: Set<Marker>.of(markers),
                                )),
                            SizedBox(height: 5.0),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: places.length,
                                    itemBuilder: (context, index) {
                                      return FutureProvider(
                                          create: (context) =>
                                              geoService.getDistance(
                                                  currentPosition.latitude,
                                                  currentPosition.longitude,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lat,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lng),
                                          child: Card(
                                            child: ListTile(
                                              title: Text(places[index].name),
                                              subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(height: 3.0),
                                                    (places[index].rating !=
                                                            null)
                                                        ? Row(
                                                            children: <Widget>[
                                                              RatingBarIndicator(
                                                                rating: places[
                                                                        index]
                                                                    .rating,
                                                                itemBuilder:
                                                                    (context,
                                                                            index) =>
                                                                        Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                                itemCount: 5,
                                                                itemSize: 10.0,
                                                                direction: Axis
                                                                    .horizontal,
                                                              )
                                                            ],
                                                          )
                                                        : Row(),
                                                    Consumer<double>(builder:
                                                        (context, meters,
                                                            widget) {
                                                      return (meters != null)
                                                          ? Text(
                                                              '${places[index].vicinity} \u00b7 ${(meters / 1609).round()} mi')
                                                          : Container();
                                                    })
                                                  ]),
                                              trailing: IconButton(
                                                icon: Icon(Icons.directions),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                onPressed: () {
                                                  _launchmapsUrl(
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lat,
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lng);
                                                },
                                              ),
                                              leading: (places[index].icon !=
                                                      null)
                                                  ? Image(
                                                      image: NetworkImage(
                                                          places[index].icon))
                                                  : Icon(Icons.navigation),
                                            ),
                                          ));
                                    }))
                          ],
                        )
                      : Center(child: CircularProgressIndicator());
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  void _launchmapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }

 
 
}
