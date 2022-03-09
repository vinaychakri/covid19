// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    this.name,
    this.type,
    this.vaccineGroup,
    this.singleDose,
    this.efficacyRate,
    this.volunteer,
    this.confirmPositive,
  });

  String name;
  String type;
  String vaccineGroup;
  String singleDose;
  String efficacyRate;
  int volunteer;
  int confirmPositive;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    name: json["name"],
    type: json["type"],
    vaccineGroup: json["vaccineGroup"],
    singleDose: json["single_dose"],
    efficacyRate: json["efficacy_rate"],
    volunteer: json["volunteer"],
    confirmPositive: json["confirm_positive"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "vaccineGroup": vaccineGroup,
    "single_dose": singleDose,
    "efficacy_rate": efficacyRate,
    "volunteer": volunteer,
    "confirm_positive": confirmPositive,
  };
}
