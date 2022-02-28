// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

CarRegistrationModel userFromJson(String str) => CarRegistrationModel.fromJson(json.decode(str));

String carRegistrationModelToJson(CarRegistrationModel data) => json.encode(data.toJson());

class CarRegistrationModel {
  CarRegistrationModel({
    required this.license_plate,
  });

  String license_plate;

  factory CarRegistrationModel.fromJson(Map<String, dynamic> json) => CarRegistrationModel(
    license_plate: json["license_plate"],
  );

  Map<String, dynamic> toJson() => {
    "license_plate": license_plate,
  };
}
