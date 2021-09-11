import 'dart:io';

import 'package:demo/cryptoModel.dart';
import 'package:demo/cryptochartModel.dart';
import 'package:http/http.dart' as http;

class API_SERVICE {
  fetchCryptoData() async {
    try {
      final response =
          await http.get(Uri.parse("https://api.coincap.io/v2/assets"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString.toString());
        return cryptoFromJson(jsonString).data;
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fetchCryptochartValues() async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.coincap.io/v2/assets/bitcoin/history?interval=d1"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString.toString());
        return cryptochartFromJson(jsonString).data;
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
