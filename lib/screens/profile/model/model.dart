// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.cars,
  });

  String accessToken;
  String refreshToken;
  User user;
  List<Car> cars;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      user: User.fromJson(json["user"]),
      cars: List<Car>.from(json["cars"].map((x) => Car.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "user": user.toJson(),
    "cars": List<dynamic>.from(cars.map((x) => x.toJson())),
  };
}

class Car {
  Car({
    required this.id,
    required this.licensePlate,
  });

  int id;
  String licensePlate;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"],
    licensePlate: json["license_plate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "license_plate": licensePlate,
  };
}

class User {
  User({
    required this.pk,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  int pk;
  String email;
  String firstName;
  String lastName;

  factory User.fromJson(Map<String, dynamic> json) => User(
    pk: json["pk"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
  };
}
