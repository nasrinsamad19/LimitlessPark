// To parse this JSON data, do
//
//     final reservation = reservationFromJson(jsonString);

import 'dart:convert';

Reservation reservationFromJson(String str) =>
    Reservation.fromJson(json.decode(str));

String reservationToJson(Reservation data) => json.encode(data.toJson());

class Reservation {
  Reservation({
    required this.active,
    required this.data,
  });

  bool active;
  Data data;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        active: json["active"],
        data: Data.fromJson(json["data"] != null ? json["data"] : ''),
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.licensePlate,
    required this.arrival,
    required this.departure,
  });

  String licensePlate;
  String arrival;
  String departure;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      licensePlate: json["license_plate"] != null ? json["license_plate"] : '',
      arrival: json["arrival"] != null
          ? DateTime.parse(json["arrival"]).toString()
          : '',
      departure: json["departure"] != null
          ? DateTime.parse(json["departure"]).toString()
          : '');

  Map<String, dynamic> toJson() => {
        "license_plate": licensePlate,
        "arrival": arrival,
        "departure": departure,
      };
}
