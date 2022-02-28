// // To parse this JSON data, do
// //
// //     final user = userFromJson(jsonString);
//
// import 'dart:convert';
//
// User userFromJson(String str) => User.fromJson(json.decode(str));
//
// String userToJson(User data) => json.encode(data.toJson());
//
// class User {
//   User({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     //required this.password,
//   });
//
//   String firstName;
//   String lastName;
//   String email;
//  // String password;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     email: json["email"],
//    // password: json["password"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "first_name": firstName,
//     "last_name": lastName,
//     "email": email,
//     //"password": password,
//   };
// }
