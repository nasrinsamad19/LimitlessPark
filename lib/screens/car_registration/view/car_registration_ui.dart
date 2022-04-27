import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/home/view/homw.dart';
import 'package:limitlesspark/screens/login/view/intro_ui.dart';
import 'package:limitlesspark/screens/login/view/reset_password.dart';
import 'package:limitlesspark/screens/notifiction/view/notification_ui.dart';
import 'package:limitlesspark/screens/signup/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:limitlesspark/main.dart';

class CarRegistartionUi extends StatefulWidget {
  const CarRegistartionUi({Key? key}) : super(key: key);

  @override
  _CarRegistartionUiState createState() => _CarRegistartionUiState();
}

class _CarRegistartionUiState extends State<CarRegistartionUi> {

  TextEditingController car1Controller = TextEditingController();
  TextEditingController car2Controller = TextEditingController();
  var platform;


  newToken(){
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      final prefs = await SharedPreferences.getInstance();
      var currentToken = prefs.getString('token');
      if (currentToken != token) {
        print('token refresh: ' + token);
        // add code here to do something with the updated token
        await prefs.setString('token', token);
      }
    });
  }


  _registerCar() async {
    print('here');
    if (Platform.isAndroid) {
      platform = "android";
    } else if (Platform.isIOS) {
      platform = "ios";
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('car1', car1Controller.text);
    await prefs.setString('car2', car2Controller.text);

    var rtoken = prefs.getString('token');
    var car1= prefs.getString('car1');
    var car2= prefs.getString('car2');
    var name =prefs.getString('name');
    var email=prefs.getString('email');
    var password= prefs.getString('password');
    var data={
      "full_name": name,
      "email": email,
      "password": password,
      "cars":car2!.isNotEmpty?[car1, car2]:[car1],
      "registration_token": rtoken,
      "device_type":platform
    };
    // var data={
    //   "registrationToken": token,
    //   "plateText": car1,
    //   "deviceType": platform,
    // };
    print('here');

    CallApi().register(data,'users/signup/').then((value) async {
      if(value == 201 ){

      otpVerify();


      }
      else if(value== 200){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('carno',car1.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home(0)),
        );
      } else{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var content = prefs.getString('error');
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context,content),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50,bottom: 20),
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/plain_background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.arrow_back_ios,color: Colors.white,size: 15, ),
                        SizedBox(width: 80,),
                        Text('Add your car'.toUpperCase(), style: TextStyle(color: Colors.white,fontSize: 15.0),),
                      ],
                    ),
                  )
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/limitless_logo.png',
                  width: 150,
                  height: 100,
                ),),
              SizedBox(
                height: 15,
              ),
              Padding(padding: EdgeInsets.only(left: 40,right: 40,),
              child:Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20,bottom: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text('Vehicle details'.toUpperCase(), style: TextStyle(color: Colors.black,fontSize: 20.0),),
                    Text('Enter your license plate number below', style: TextStyle(color: ColorNames().grey,fontSize: 9.0),),
                    Container(
                      padding: EdgeInsets.only(left: 40,right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CAR 1', style: TextStyle(color: Colors.black,fontSize: 11),),
                          Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorNames().grey),
                                borderRadius: BorderRadius.circular(5),
                                color: ColorNames().lightgrey

                            ),
                            child:TextFormField(
                              maxLength: 7,
                              decoration: InputDecoration(
                                counterText: '',
                                counterStyle: TextStyle(fontSize: 0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide( color: ColorNames().grey),
                                ),
                                hintText: 'License plate no.',
                                hintStyle: TextStyle(color: ColorNames().darkgrey, fontSize: 14.0),
                              ),
                              controller: car1Controller,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'Please enter Plate Number';
                                }
                              },
                              //onSaved: (val)=> password=val.toString(),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text('CAR 2', style: TextStyle(color: Colors.black,fontSize: 11.0),),
                          Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorNames().grey),
                                borderRadius: BorderRadius.circular(5),
                                color: ColorNames().lightgrey

                            ),
                            child:TextFormField(
                              maxLength: 7,
                              decoration: InputDecoration(
                                counterText: '',
                                counterStyle: TextStyle(fontSize: 0),
                                fillColor: ColorNames().blue,
                                hintText: 'license plate no.',
                                hintStyle: TextStyle(color: ColorNames().darkgrey, fontSize: 14.0),
                              ),
                              controller: car2Controller,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'Please enter Plate Number';
                                }
                              },
                              //validator:(val)=> validatePassword(val.toString()),
                              //onSaved: (val)=> password=val.toString(),
                            ),
                          )
                        ],
                      ) ,
                    )
                  ],

                ),
              ),
                  ),
              SizedBox(height: 200,),
              Align(
                alignment: Alignment.bottomCenter,
                child:Container(
                  height: height/12,
                  width: width/1.6,
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorNames().blue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () async {
                            if(car1Controller.text.isNotEmpty){
                              MyAppState().getToken();
                              _registerCar();
                            }

                           // setcar();

                          },
                          child: Center(
                            child: Text('submit'.toUpperCase(),
                                style: TextStyle(color: Colors.white,fontSize: 16)),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context,value) {
    return new AlertDialog(
      title: const Text('Error'),
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

  //
  // setcar() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('car1', car1Controller.text);
  //   await prefs.setString('car2', car2Controller.text);
  //   print(  prefs.getString('car1'));
  //   if(car2Controller.text.isNotEmpty){
  //     sub();
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => Notification_ui()),
  //     );
  //   }
  //   else{
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) => _buildPopUp(context)
  //
  //     );
  //   }
  //
  // }

  sub() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var subscribed = prefs.getStringList('subscribed');
   var car1= prefs.getString('car1');
    var car2= prefs.getString('car2');


    List topics = [
      car1,
      car2,
    ];
    if(car1!.isNotEmpty){
      await FirebaseMessaging.instance
          .subscribeToTopic(topics[0]);

      await FirebaseFirestore.instance
          .collection('topics')
          .doc(token)
          .set({topics[0]: 'subscribe'},
          SetOptions(merge: true));
      setState(() {
        subscribed?.add(topics[0]);
      });
    }
    if(car2!.isNotEmpty){
      await FirebaseMessaging.instance
          .subscribeToTopic(topics[1]);
      await FirebaseFirestore.instance
          .collection('topics')
          .doc(token)
          .set({topics[1]: 'subscribe'},
          SetOptions(merge: true));
      setState(() {
        subscribed?.add(topics[1]);
      });
    }


  }

  otpVerify() async {
    final prefs = await SharedPreferences.getInstance();
    var email=prefs.getString('email');
    print(email);
   var data ={
     "email": email,
    "reason": "account_activation"
  };

    CallApi().getOtp(data, 'users/get-otp/').then((value) async {
     if (value== 200){
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => ResetPassword(email: 'null',)),
       );
     }else{
       SharedPreferences prefs = await SharedPreferences.getInstance();
       var content = prefs.getString('getOtpError');
       showDialog(
         context: context,
         builder: (BuildContext context) => _buildPopupDialog(context,content),
       );
     }
    }
      );

}
}
