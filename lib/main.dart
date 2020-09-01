import 'package:essf/LandingPage.dart';
import 'package:essf/auth.dart';
import 'package:essf/maps/Geolocatorservice.dart';
import 'package:essf/maps/PlacesService.dart';
import 'package:essf/maps/Places_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final locatorService = GeolocatorService();
  final placesService = PlacesService();

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<Result>>>(
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )
      ],
      child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(primarySwatch: Colors.blue),
          home: LandingPage(
            auth: Auth(),
          )),
    );
  }
}
