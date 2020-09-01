import 'package:essf/models/EmergencyModel.dart';

import 'package:http/http.dart' as http;


class Emergencies {
  static const String url = "https://data.melbourne.vic.gov.au/api/views/jtcb-iab6/rows.json?accessType=DOWNLOAD";
  static Future<List<View>> getData() async {
    try {
      final response =await http.get(url);
      if(response.statusCode==200){
        final List<View>emergencyModel=emergencyModelFromJson(response.body) as List<View> ;
        return emergencyModel;
      }
      else return List<View>();
    } catch (e) {
      return List<View>();
    }
  }
}
