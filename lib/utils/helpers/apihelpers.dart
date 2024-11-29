import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/api_model.dart';

class Apihelper {
  Apihelper._();

  static Apihelper api = Apihelper._();

  Future getdata({required String search}) async {
    var ans = await http.get(
      Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=3c5009be4d49494f9d245829232208&q=$search||surat&days=1&aqi=no&alerts=no"),
    );
    if (ans.statusCode == 200) {
      var body = ans.body;
      Map decodegata = jsonDecode(body);
      api_model data = api_model.js(data: decodegata);
      return data;
    } else {
      return null;
    }
  }
}
