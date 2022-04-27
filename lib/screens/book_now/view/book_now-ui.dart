import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/profile/model/model.dart';
import 'package:limitlesspark/screens/signup/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookNow extends StatefulWidget {
  const BookNow({Key? key}) : super(key: key);

  @override
  BookNowState createState() => BookNowState();
}

class BookNowState extends State<BookNow> {
  TextEditingController dateinputarrival = TextEditingController();
  TextEditingController dateinputDeparture = TextEditingController();
  TextEditingController _timecontroler = TextEditingController();

  //String _selectedDate1=DateFormat("yyyy-MM-ddTHH:mm:ss").add_jm().format(DateTime.now());
  //String _selectedDate1=DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now().t);
  //String _selectedDate1 = DateTime.now().toString();

  var car1Id;
  var car2Id;
  final _formKey = GlobalKey<FormState>();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();
  DateTime _selectedDate1 = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();
  var oldArrivalTime;
  var oldDTime;

  Future<void> _selectDate1(BuildContext context) async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2032),
    );
    if (d != null)
      setState(() {
        dateinputDeparture.text = new DateFormat("yyyy-MM-dd").format(d);
      });
  }

  _selectTime1(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2032),
    );
    if (d != null)
      setState(() {
        dateinputarrival.text = new DateFormat("yyyy-MM-dd").format(d);
      });
  }

  _selectTime2(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime2,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime2) {
      setState(() {
        selectedTime2 = timeOfDay;
      });
    }
  }

  String? dropdownvalue;

  // List of items in our dropdown menu
  var items = [];

  getCarList() async {
    CallApi().checkReservation().then((value) async {
      if (value.active == false) {
        setState(() {
          cancel = false;
        });
        print('false cancel');
        futureData = CallApi().fetchprofile();
        print(futureData.then((value) {
          var car1 = value!.cars.first;
          var car2 = value!.cars.last;
          if (value.cars.first != value!.cars.last) {
            setState(() {
              items = [car1.toString(), car2.toString()];
            });
          } else {
            setState(() {
              items = [car1.toString()];
            });
          }
          print(items);
        }));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('plateNo', value.data.licensePlate);
        print(cancel);
        setState(() {
          print(value.data);
          DateTime dtA = DateTime.parse(value.data.arrival);
          dateinputarrival.text = DateFormat("yyyy-MM-dd").format(dtA);
          DateTime dtD = DateTime.parse(value.data.departure);
          dateinputDeparture.text = DateFormat("yyyy-MM-dd").format(dtD);
          print(dtA);

          oldArrivalTime = DateFormat("hh:mm a").format(dtA);
          oldDTime = DateFormat("hh:mm a").format(dtD);
          print(oldArrivalTime);
          print(oldDTime);
          dropdownvalue = value.data.licensePlate;
          items = [value.data.licensePlate];
          cancel = true;
        });
      }
    });
  }

  late Future<Profile> futureData;
  bool cancel = false;

  @override
  void initState() {
    // TODO: implement initState
    dateinputarrival.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    dateinputDeparture.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
    getCarList();
    Timer mytimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        getCarList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 40, right: 40, top: 30),
        child: Column(
          children: [
            !cancel
                ? Text('')
                : Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      'Reservation Details'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            signUpForm(context),
          ],
        ),
      ),
      bottomNavigationBar: cancel
          ? Container(
              height: 50,
              width: width / 1.5,
              padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
              child: Container(
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //     colors: [Colors.blue, ColorNames().lightBlue]),
                  color: ColorNames().darkBlue,
                  boxShadow: [],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        var data = {"license_plate": dropdownvalue};
                        CallApi()
                            .postCancel(data, 'reservations/cancel/')
                            .then((value) async {
                          if (value == 200) {
                            getCarList();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(
                                      context, 'Cancellation on process'),
                            );
                          } else {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var content = prefs.getString('error');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context, content),
                            );
                          }
                        });
                      },
                      child: Center(
                        child: Text('CANCEL BOOKING',
                            style: TextStyle(color: Colors.white)),
                      )),
                ),
              ),
            )
          : Container(
              height: 50,
              width: width / 1.5,
              padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
              child: Container(
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //     colors: [Colors.blue, ColorNames().lightBlue]),
                  color: ColorNames().darkBlue,
                  boxShadow: [],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        if (dropdownvalue != null) {
                          _bookNow();
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context, 'Select car'),
                          );
                        }
                      },
                      child: Center(
                        child: Text('BOOK NOW',
                            style: TextStyle(color: Colors.white)),
                      )),
                ),
              ),
            ),
    );
  }

  _bookNow() {
    // var arrival= DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dateinputarrival.text).toIso8601String();
    //var departure= DateFormat().parse(dateinputDeparture.text).toIso8601String();

    //print(arrival);
    print(dateinputDeparture.text);
    //print(DateFormat.yMMMd().parse(dateinputDeparture.text));
    print(selectedTime);
    var date = selectedTime.format(context);
    print(date);
    DateTime date2 = DateFormat.jm().parse(date);
    print(date2.toString() + ';;');
    var fdate = date2.toString().split(" ").elementAt(1);
    var finalDate =
        DateTime.parse(dateinputDeparture.text + ' ' + fdate).toIso8601String();
    print(finalDate);
    print(date2);

    print(selectedTime2);
    var adate = selectedTime2.format(context);
    print(date);
    DateTime adate2 = DateFormat.jm().parse(adate);
    var ardate = adate2.toString().split(" ").elementAt(1);
    var finalADate =
        DateTime.parse(dateinputarrival.text + ' ' + ardate).toIso8601String();
    print(finalADate);
    print(finalDate);
    var data = {
      "license_plate": dropdownvalue.toString(),
      "arrival": finalADate,
      "departure": finalDate,
    };

    CallApi().postBookNow(data, 'reservations/create/').then((value) {
      if (value == true) {
        getCarList();
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              _buildPopupDialog(context, 'reservation on process'),
        );
        print('sucees');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              _buildPopupDialog(context, value.toString()),
        );
        print('errorrr');
      }
    });
  }

  Widget _buildPopupDialog(BuildContext context, value) {
    return new AlertDialog(
      title: const Text('Message'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('$value'),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget signUpForm(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Arrival',
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
            SizedBox(
              height: 5,
            ),
            // Container(
            //   height: 40,
            //   child: TextFormField(
            //     enabled: !cancel?true:false,
            //     decoration: InputDecoration(
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: ColorNames().grey),
            //       ),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(color: ColorNames().grey),
            //       ),
            //       hintText: DateTime.now().toString(),
            //       hintStyle:
            //       TextStyle(color: Colors.black, fontSize: 10.0),
            //     ),
            //     style: TextStyle(color: Colors.black, fontSize: 12.0),
            //     controller: dateinputarrival,
            //     //initialValue: _selectedDate1,
            //     validator: (val) {
            //       Pattern pattern =
            //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
            //       RegExp regex = RegExp(pattern.toString());
            //       if (val!.isEmpty) {
            //         return 'Please enter email';
            //       } else {
            //         if (!regex.hasMatch(val)) {
            //           return 'Invalid Email';
            //         }
            //       }
            //     },
            //     //onSaved: (input)=> loginRequestModel.email= input.toString(),
            //   ),
            // ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorNames().grey),
                  ),
                  height: 40,
                  child: Row(
                    children: [
                      !cancel
                          ? Text(
                              dateinputarrival.text,
                              style: TextStyle(color: Colors.black),
                            )
                          : Text(
                              dateinputarrival.text,
                              style: TextStyle(color: Colors.grey),
                            ),
                      IconButton(
                        icon: !cancel
                            ? Icon(Icons.calendar_today)
                            : Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                              ),
                        tooltip: 'Tap to open date picker',
                        onPressed: () {
                          !cancel ? _selectDate2(context) : null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorNames().grey),
                  ),
                  height: 40,
                  child: Row(
                    children: [
                      !cancel
                          ? Text(
                              selectedTime2.format(context),
                              style: TextStyle(color: Colors.black),
                            )
                          : Text(
                              oldArrivalTime.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                      IconButton(
                        icon: !cancel
                            ? Icon(
                                Icons.access_time,
                              )
                            : Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ),
                        tooltip: 'Tap to open date picker',
                        onPressed: () {
                          !cancel ? _selectTime2(context) : null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Departure',
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorNames().grey),
                  ),
                  height: 40,
                  child: Row(
                    children: [
                      !cancel
                          ? Text(
                              dateinputDeparture.text,
                              style: TextStyle(color: Colors.black),
                            )
                          : Text(
                              dateinputDeparture.text,
                              style: TextStyle(color: Colors.grey),
                            ),
                      IconButton(
                        icon: !cancel
                            ? Icon(Icons.calendar_today)
                            : Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                              ),
                        tooltip: 'Tap to open date picker',
                        onPressed: () {
                          !cancel ? _selectDate1(context) : null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorNames().grey),
                  ),
                  height: 40,
                  child: Row(
                    children: [
                      !cancel
                          ? Text(
                              selectedTime.format(context),
                              style: TextStyle(color: Colors.black),
                            )
                          : Text(
                              oldDTime,
                              style: TextStyle(color: Colors.grey),
                            ),
                      IconButton(
                        icon: !cancel
                            ? Icon(Icons.access_time)
                            : Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ),
                        tooltip: 'Tap to open date picker',
                        onPressed: () {
                          !cancel ? _selectTime1(context) : null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Container(
            //   height: 40,
            //   child: TextFormField(
            //     enabled: !cancel?true:false,
            //     decoration: InputDecoration(
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: ColorNames().grey),
            //       ),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(color: ColorNames().grey),
            //       ),
            //       hintText: DateTime.now().toString(),
            //       hintStyle:
            //       TextStyle(color: ColorNames().grey, fontSize: 10.0),
            //     ),
            //     style: TextStyle(color: Colors.black, fontSize: 12.0),
            //     controller: dateinputDeparture,
            //     //initialValue: _selectedDate1,
            //     validator: (val) {
            //       Pattern pattern =
            //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
            //       RegExp regex = RegExp(pattern.toString());
            //       if (val!.isEmpty) {
            //         return 'Please enter email';
            //       } else {
            //         if (!regex.hasMatch(val)) {
            //           return 'Invalid Email';
            //         }
            //       }
            //     },
            //     //onSaved: (input)=> loginRequestModel.email= input.toString(),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Car',
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              width: width / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: ColorNames().grey),
              ),
              padding: EdgeInsets.all(8),
              child: DropdownButton(
                isExpanded: true,
                borderRadius: BorderRadius.circular(5),
                underline: Container(),
                style: !cancel
                    ? TextStyle(color: Colors.black, fontSize: 12)
                    : TextStyle(color: Colors.grey, fontSize: 12),

                // Initial Value
                value: dropdownvalue,
                hint: Text('Select your car',
                    style: TextStyle(color: Colors.black, fontSize: 12)),

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((var items) {
                  return DropdownMenuItem<String>(
                    value: items,
                    child: !cancel
                        ? Text(items,
                            style: TextStyle(color: Colors.black, fontSize: 12))
                        : Text(items,
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: !cancel
                    ? (newValue) {
                        setState(() {
                          dropdownvalue = newValue! as String?;
                        });
                      }
                    : null,
              ),
            )
          ],
        ));
  }
}
