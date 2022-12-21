import 'dart:convert';

import 'package:test_esign_pspdfplugin/model/prices.dart';
import 'package:http/http.dart' as http;

class NetworkData {
  Future<MetalPrices> getMetalPrices() async {
    try {
      var url = Uri.parse("http://52.221.73.12:3000/home/getPrices");
      //var url = Uri.http("52.221.73.12:3000", 'home/getPrices');
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return MetalPrices.fromJson(body);
      } else {
        throw Exception(response.body.toString());
      }
    } catch (exp) {
      throw Exception(exp.toString());
    }
  }
}
