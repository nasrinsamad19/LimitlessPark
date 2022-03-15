import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:limitlesspark/screens/login/view/model.dart';
import 'package:limitlesspark/screens/profile/model/model.dart';
import 'package:limitlesspark/screens/signup/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _baseUrl = "https://api.limitlesspark.net/";

  postData(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    var res = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    print("Result: ${res.body}");

    print(res.statusCode);
    if (res.statusCode == 201) {
      print('sucees');
      Profile.fromJson(jsonDecode(res.body));
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      //return Exception('Failed to create album.';
      return false;
    }
  }

  postCarRegistration(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var res =
        await http.post(Uri.parse(fullUrl), body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token ${token}',
    });
    print(res.statusCode);
    print(res.reasonPhrase);
    print(res.body);
    if (res.statusCode == 201) {
      print('sucees');
      // User.fromJson(jsonDecode(res.body));
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      //return Exception('Failed to create album.';
      return false;
    }
  }

  postSocialGoogleLogin(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    var res = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    print(res.statusCode);
    print(res.reasonPhrase);
    print(res.body);
    if (res.statusCode == 201) {
      print('sucees');
      //User.fromJson(jsonDecode(res.body));
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      //return Exception('Failed to create album.';
      return false;
    }
  }

  postSocialFacebbokLogin(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    var res = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    print(res.statusCode);
    print(res.reasonPhrase);
    print(res.body);
    if (res.statusCode == 201) {
      print('sucees');
      //User.fromJson(jsonDecode(res.body));
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      //return Exception('Failed to create album.';
      return false;
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<Profile> login(LoginRequestModel loginRequestModel) async {
    String lurl = 'accounts/login/';
    String url = _baseUrl + lurl;
    final response =
        await http.post(Uri.parse(url), body: loginRequestModel.toJson());
    print(response.statusCode);
    // print(response.body.toString());
    final responseJson = json.decode(response.body);
    //print("Result: ${response.body}");
    print(responseJson);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', responseJson['access_token']);
    var jsonList =
        responseJson['cars'].map((item) => jsonEncode(item)).toList();
    // await prefs.setString('user',responseJson['user'].toString());
    // var user = prefs.getString('user');
    // user!.replaceAll("[{}]", "");
    // List<String> stringList = user!.split(",").toList();
    // var currentUser = json.decode(stringList[0]);
    // print(currentUser);
    //
    // await prefs.setString('currentuser',responseJson['user'].toString());
    await prefs.setStringList(
      'cars',
      jsonList.cast<String>(),
    );
    var token = prefs.getStringList('cars');
    // print(token);
    // print(token![0]);
    // var users = prefs.getString('user');
    // print(users);
    // var cUser = json.encode(user!);
    // print(cUser);
    // var currentUser = json.decode(cUser!);
    // print(currentUser);

    // Map<String, dynamic> mapUser = jsonDecode(stringList[0]);
    // User user1 = User.fromJson(mapUser);
    // print(user1.firstName);
    Map<String, dynamic> map1 = jsonDecode(token![0]);
    Car car1 = Car.fromJson(map1);
    print(car1.licensePlate);
    await prefs.setString('car1', car1.licensePlate);
    await prefs.setInt('car1Id', car1.id);
    Map<String, dynamic> map2 = jsonDecode(token![1]);
    Car car2 = Car.fromJson(map2);
    print(car1.licensePlate);
    await prefs.setString('car2', car2.licensePlate);
    await prefs.setInt('car2Id', car2.id);

    if (response.statusCode == 200 || response.statusCode == 400) {
      Profile profile = Profile.fromJson(json.decode(response.body));
      print(profile.user.firstName);
      await prefs.setString('firstName', profile.user.firstName);
      await prefs.setString('lastName', profile.user.lastName);
      await prefs.setString('email', profile.user.email);
      return profile;
    } else {
      throw Exception('Faild to load data');
    }
  }

  Future<http.Response> fetchActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
        await http.get(Uri.parse(_baseUrl + 'reservations/list/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token ${token}',
    });
    print(response.body);
    return jsonDecode(response.body);
    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    //   return Album.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
  }

  postBookNow(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var res =
        await http.post(Uri.parse(fullUrl), body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token ${token}',
    });
    print(res.statusCode);
    print(res.reasonPhrase);
    print(res.body);
    if (res.statusCode == 200) {
      print('sucees');
      // User.fromJson(jsonDecode(res.body));
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      //return Exception('Failed to create album.';
      return false;
    }
  }

  postUpdateProfile(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var res =
        await http.post(Uri.parse(fullUrl), body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token ${token}',
    });
    print(res.statusCode);
    print(res.reasonPhrase);
    print(res.body);
    if (res.statusCode == 200) {
      print('sucees');
      // User.fromJson(jsonDecode(res.body));
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      //return Exception('Failed to create album.';
      return false;
    }
  }

  postUpdateCar(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(data[0]);
    var res =
        await http.put(Uri.parse(fullUrl), body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token ${token}',
    });
    print(res.statusCode);
    print(res.reasonPhrase);
    print(res.body);
    if (res.statusCode == 200) {
      print('sucees');
      // User.fromJson(jsonDecode(res.body));
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      //return Exception('Failed to create album.';
      return false;
    }
  }

   logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
    await http.get(Uri.parse(_baseUrl + 'accounts/logout/'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token ${token}',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('sucees');
      // User.fromJson(jsonDecode(res.body));
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      //return Exception('Failed to create album.';
      return false;
    }    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    //   return Album.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
  }

  Future<http.Response> fetchNotifictions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
    await http.get(Uri.parse("https://api.catapush.com/1/messages"), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token ${token}',
    });
    print(response.body);
    return jsonDecode(response.body);
    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    //   return Album.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
  }


}
