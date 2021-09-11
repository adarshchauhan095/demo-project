// To parse this JSON data, do
//
//     final cryptochart = cryptochartFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Cryptochart cryptochartFromJson(String str) =>
    Cryptochart.fromJson(json.decode(str));

String cryptochartToJson(Cryptochart data) => json.encode(data.toJson());

class Cryptochart {
  Cryptochart({
    required this.data,
    required this.timestamp,
  });

  List<Datum> data;
  int timestamp;

  factory Cryptochart.fromJson(Map<String, dynamic> json) => Cryptochart(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "timestamp": timestamp,
      };
}

class Datum {
  Datum({
    required this.priceUsd,
    required this.time,
    // required this.date,
  });

  String? priceUsd;
  int time;
  // DateTime date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        priceUsd: json["priceUsd"],
        time: json["time"],
        // date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "priceUsd": priceUsd,
        "time": time,
        // "date": date.toIso8601String(),
      };
}
