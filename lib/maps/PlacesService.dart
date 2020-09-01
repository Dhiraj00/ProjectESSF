import 'package:essf/maps/Places_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class PlacesService{
  final key="AIzaSyAcIZtJ-hFBSs406zJcHrM3gitAjVA7110";
Future<List<Result>>getPlaces(double lat, double lng)async{
  var response=await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=church,hospital,police,hindu_temple,mosque,police&rankby=distance&key=AIzaSyAcIZtJ-hFBSs406zJcHrM3gitAjVA7110');
  var json=convert.jsonDecode(response.body);
  var jsonResults=json['results']as List;
  return jsonResults.map((place)=>Result.fromJson(place)).toList();

   
}



}