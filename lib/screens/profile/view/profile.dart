import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/login/view/intro_ui.dart';
import 'package:limitlesspark/screens/login/view/model.dart';
import 'package:limitlesspark/screens/profile/model/model.dart';
import 'package:limitlesspark/screens/signup/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUI extends StatefulWidget {
  const ProfileUI({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileUI> {
  TextEditingController emailController = TextEditingController();
  TextEditingController car1 = TextEditingController();
  TextEditingController car2 = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController palteNoController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool email= false;
  bool fname= false;
  bool lname= false;
  bool car1Chaged = false;
  bool car2Chaged = false;
  Profile? futureAlbum;
  var token;


  String? validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern.toString());
    if (value.isEmpty) {
      return 'Please enter Password';
    }
    else if(value.length<6){
      return "Password must contain at least six characters";
    }
    else if (!regex.hasMatch(value)) {
      return 'Password must contain uppercase and lowercase \n letters, numbers and special characters.';
    }
    else
      return null;
  }


  @override
  void initState() {
    // TODO: implement initState
    fetchdata();
    super.initState();
  }
  fetchdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fnameController.text = prefs.getString('firstName')!;
    lnameController.text= prefs.getString('lastName')!;
    emailController.text= prefs.getString('email')!;
    car1.text=prefs.getString('car1')!;
    car2.text=prefs.getString('car2')!;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 40,right: 40,top: 30),
        child: Column(
        children: [
          signUpForm(context),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text('Cars', style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Car 1', style: TextStyle(
                  color: ColorNames().lightgrey,
                  fontSize: 14,
                )),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 137,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide( color: ColorNames().grey),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide( color: ColorNames().grey),
                      ),
                      hintText: 'S 123456',
                      hintStyle: TextStyle(color: ColorNames().lightgrey, fontSize: 14.0),
                    ),
                    controller: car1,
                    onChanged: (val){
                      setState(() {
                        car1Chaged = true;
                      });
                    },
                    validator:(val)=> validatePassword(val.toString()),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Car 2', style: TextStyle(
                  color: ColorNames().lightgrey,
                  fontSize: 14,
                )),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 137,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide( color: ColorNames().grey),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide( color: ColorNames().grey),
                      ),
                      hintText: 'S 123456',
                      hintStyle: TextStyle(color: ColorNames().lightgrey, fontSize: 14.0),
                    ),
                    controller: car2,
                    onChanged: (val){
                      setState(() {
                        car2Chaged = true;
                      });
                    },
                    validator:(val)=> validatePassword(val.toString()),
                  ),
                ),
              ],
            ),
          )

        ],  
        ),
      ),
      bottomNavigationBar: Container(
        child:  Row(
          children: [
            Container(
              height: height / 10,
              width: width / 2,
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
                        _profileUpdate();

                      },
                      child: Center(
                        child: Text('UPDATE',
                            style: TextStyle(color: Colors.white)),
                      )),
                ),
              ),
            ),
            Container(
              height: height / 10,
              width: width / 2,
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
                        _signOut();

                      },
                      child: Center(
                        child: Text('LOG OUT',
                            style: TextStyle(color: Colors.white)),
                      )),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
  // FutureBuilder<Profile> buildFutureBuilder() {
  //   return FutureBuilder<Profile>(
  //     future: _futureAlbum,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return
  //       }
  //       else if (snapshot.hasError) {
  //         return Text('${snapshot.error}');
  //       }
  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }
  Widget signUpForm(BuildContext context){
    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text('First Name', style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              )),
            ),
            Container(
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: ColorNames().grey),
                  ),
                  hintText: token,
                  hintStyle: TextStyle(color: ColorNames().lightgrey, fontSize: 14.0),
                ),
                controller: fnameController,
                validator: (val){
                  if(val!.isEmpty){
                    return 'Please enter Name';
                  } else if(val.contains(RegExp(r'[0-9]'))){
                    return 'Please check your entry';
                  }
                },
                onChanged: (val){
                  setState(() {
                    fname = true;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text('Last Name', style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              )),
            ),
            Container(
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: ColorNames().grey),
                  ),
                  hintText: 'Client name',
                  hintStyle: TextStyle(color: ColorNames().lightgrey, fontSize: 14.0),
                ),
                controller: lnameController,
                validator: (val){
                  if(val!.isEmpty){
                    return 'Please enter Name';
                  } else if(val.contains(RegExp(r'[0-9]'))){
                    return 'Please check your entry';
                  }
                },
                onChanged: (val){
                  setState(() {
                    lname = true;
                  });
                },              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('Email', style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              )),
            ),
            Container(
              height: 30,
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: ColorNames().grey),
                  ),
                  hintText: 'Client email',
                  hintStyle: TextStyle(color: ColorNames().lightgrey, fontSize: 14.0),
                ),
                controller: emailController,
                validator: (val){
                  Pattern pattern =
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                  RegExp regex = RegExp(pattern.toString());
                  if(val!.isEmpty){
                    return 'Please enter email';
                  } else {
                    if(!regex.hasMatch(val)){
                      return 'Invalid Email';
                    }
                  }
                },
                onChanged: (val){
                  setState(() {
                    email = true;
                  });
                },              ),
            ),
            // Container(
            //   alignment: Alignment.topLeft,
            //   padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            //   child: Text('Mobile', style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 14,
            //   )),
            // ),
            // Container(
            //   height: 30,
            //   child: TextFormField(
            //     keyboardType: TextInputType.phone,
            //     decoration: InputDecoration(
            //       enabledBorder: UnderlineInputBorder(
            //         borderSide: BorderSide( color: ColorNames().grey),
            //       ),
            //       hintText: 'Client contact number',
            //       hintStyle: TextStyle(color: ColorNames().lightgrey, fontSize: 14.0),
            //     ),
            //     controller: phoneNoController,
            //     validator:(val)=> validatePassword(val.toString()),
            //     onSaved: (val)=> password=val.toString(),
            //   ),
            // ),

          ],
        ),
      ),

    );
  }

  _profileUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var car1Id =prefs.getInt('car1Id')!;
    var car2Id =prefs.getInt('car2Id')!;

    var data={
        'email': emailController.text,
        'first_name': fnameController.text,
        'last_name': lnameController.text,
    };

    var firstCar= {
      'license_plate':car1.text,
    };

    var secondCar= {
      'license_plate':car2.text,
    };
    if(car1Chaged == true){
      CallApi().postUpdateCar(firstCar,'cars/update/'+car1Id.toString()+'/').then((value){
        if(value == true){
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Home()),
          // );
          print('sucees');
        }
        else{
          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) => _buildPopUp(context)
          //
          // );
          print('errorrr');

        }
      });
    }
    if(car2Chaged == true){
      CallApi().postUpdateCar(secondCar,'cars/update/'+car2Id.toString()+'/').then((value){
        if(value == true){
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Home()),
          // );
          print('sucees');
        }
        else{
          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) => _buildPopUp(context)
          //
          // );
          print('errorrr');
        }
      });
    }
    if(lname == true || fname == true || email== true) {
      CallApi().postUpdateProfile(data,'accounts/profile/update/').then((value){
        if(value == true){
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Home()),
          // );
          print('sucees');
        }
        else{
          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) => _buildPopUp(context)
          //
          // );
          print('errorrr');

        }
      });
    }

  }

  _signOut() {
    CallApi().logout().then((value){
      if(value == true){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => intro_ui()),
        );
        print('sucees');
      }
      else{
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) => _buildPopUp(context)
        //
        // );
        print('errorrr');
      }
    });
  }

}

