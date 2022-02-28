
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:limitlesspark/screens/car_registration/view/car_registration_ui.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/login/view/login_ui.dart';
import 'package:limitlesspark/screens/signup/api.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController correctPasswordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController palteNoController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  _register(){
    var data={
      'first_name': fnameController.text,
      'last_name': lnameController.text,
      'email' : emailController.text,
      'password': passwordController.text
    };

     CallApi().postData(data,'accounts/register/').then((value){
       if(value == true){
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => CarRegistartionUi()),
         );
       }
       else{
         showDialog(
             context: context,
             builder: (BuildContext context) => _buildPopUp(context)

         );
       }
     });
    // print  ( res);
    //  var body = json.encode(res);
    // print(res);
    //print(body.toString());
    // if(body){
    //   print('sucess');
    // }

  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String email='';
  String password='';
  String fname='';
  String lname='';
  String plateNo='';
  String phoneNo='';

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

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please enter Password';
    }
    else if(passwordController.text != value){
      return "Enter correct password";
    }
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/plain_background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
       child: Stack(
         children: [
           Align(
             alignment: Alignment.topCenter,
             child:  GestureDetector(
                 behavior: HitTestBehavior.translucent,
                 onTap: (){
                   Navigator.pop(context);
                 },
                 child: Container(
                   // color: Colors.white,
                   //  height: 50,
                   //  width: 50,
                   child: Row(
                     children: [
                       SizedBox(
                         width: 10,
                       ),
                       GestureDetector(
                         behavior: HitTestBehavior.translucent,
                         onTap: (){
                           Navigator.pop(context);
                         },
                         child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 15, ),
                       ),
                       SizedBox(
                         width: 60,
                       ),
                       Text('register your account'.toUpperCase(), style: TextStyle(color: Colors.white,fontSize: 15.0),),
                     ],
                   ),
                 )

             ),
           ),
           SingleChildScrollView(
             physics: ClampingScrollPhysics(),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(
                   height: 40,
                 ),
                 Align(
                   alignment: Alignment.center,
                   child: Image.asset(
                     'assets/images/limitless_logo.png',
                     width: 150,
                     height: 100,
                   ),),
                 SizedBox(
                   height: 30,
                 ),
                 Container(
                   alignment: Alignment.center,
                   padding: EdgeInsets.only(left: 50,right: 50),
                   child: signUpForm(context),
                 ),
                 SizedBox(
                   height: 30,
                 ),
                 Align(
                   alignment: Alignment.center,
                   child: InkWell(
                     child: Text('Forgot your password?'.toUpperCase(),
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 11.0),
                     ),
                     onTap: () {
                       // Navigator.push(
                       //   context,
                       //   MaterialPageRoute(builder: (context) => ResetPassword()),
                       // );
                     },
                   ),
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 Align(
                   alignment: Alignment.center,
                   child:Container(
                     height: height/12,
                     width: width/1.54,
                     padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
                     child: Container(
                       decoration: BoxDecoration(
                         gradient: LinearGradient(colors: [
                           ColorNames().lightBlue,
                           Colors.blue
                         ]),
                         borderRadius: BorderRadius.circular(20),
                       ),
                       child: Material(
                         color: Colors.transparent,
                         child: InkWell(
                             onTap: () {
                               if(_formKey.currentState!.validate()){
                                 _formKey.currentState!.save();
                                 // _scaffoldKey.currentState!.showSnackBar(
                                 //     new SnackBar(
                                 //       content: new Text(
                                 //           "Success"),
                                 //     ));
                               }
                               _register();
                             },
                             child: Center(
                               child: Text('next'.toUpperCase(),
                                   style: TextStyle(color: Colors.white)),
                             )),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                     padding: EdgeInsets.only(left: 50),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Register with one of the following instead', style: TextStyle(color: Colors.white, fontSize: 13.0),),
                         SizedBox(
                           height: 5,
                         ),
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               decoration: BoxDecoration(
                                 border: Border.all(color: Colors.white),
                                 borderRadius: BorderRadius.circular(5),
                               ),
                               child: Material(
                                 color: Colors.transparent,
                                 child: InkWell(
                                   onTap:  () async {
                                     // Authentication.initializeFirebase(context: context);
                                     // User? user =
                                     // await Authentication.signInWithGoogle(context: context);
                                     // if (user != null) {
                                     //   Navigator.of(context).pushReplacement(
                                     //     MaterialPageRoute(
                                     //       builder: (context) => UserInfoScreen(
                                     //         user: user,
                                     //       ),
                                     //     ),
                                     //   );
                                     // }

                                   },
                                   child: Image.asset(
                                     'assets/images/google_icon.png',
                                     width: 30,
                                     height: 30,
                                   ),),
                               ),
                             ),
                             SizedBox(
                               width: 5,
                             ),
                             // Container(
                             //   decoration: BoxDecoration(
                             //     gradient: LinearGradient(colors: [
                             //       ColorNames().lightBlue,
                             //       Colors.blue
                             //     ]),
                             //     borderRadius: BorderRadius.circular(10),
                             //   ),
                             //   child: Material(
                             //     color: Colors.transparent,
                             //     child: InkWell(
                             //       onTap: () {
                             //         // Navigator.push(
                             //         //   context,
                             //         //   MaterialPageRoute(builder: (context) => loginUi()),
                             //         // );
                             //       },
                             //       child: Image.asset(
                             //         'assets/images/apple_icon.png',
                             //         width: 30,
                             //         height: 30,
                             //       ),),
                             //   ),
                             // ),
                             // SizedBox(
                             //   width: 5,
                             // ),
                             Container(
                               decoration: BoxDecoration(
                                 border: Border.all(color: Colors.white),
                                 borderRadius: BorderRadius.circular(5),
                               ),
                               child: Material(
                                 color: Colors.transparent,
                                 child: InkWell(
                                   onTap: () async {
                                     // FacebookAuth.instance.login(permissions: ["public_profile", "email"]).then((value) {
                                     //   FacebookAuth.instance.getUserData().then((
                                     //       userData) {
                                     //     print(userData);
                                     //   });
                                     // });
                                   },
                                   child:Image.asset(
                                     'assets/images/facebook_logo.png',
                                     width: 30,
                                     height: 30,
                                   ),),
                               ),
                             ),
                           ],
                         )
                       ],
                     )
                 ),
                 SizedBox(
                   height: 30,
                 ),
                 Align(
                   alignment: Alignment.center,
                   child: Text(
                     'Already have an account?'.toUpperCase(),
                     style: TextStyle(
                         color: Colors.white,
                         fontSize: 12),
                   ),
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 Align(
                   alignment: Alignment.center,
                   child:Container(
                     height: height/12,
                     width: width/1.54,
                     padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
                     child: Container(
                       decoration: BoxDecoration(
                         border: Border.all(color: ColorNames().blue),
                         borderRadius: BorderRadius.circular(20),
                       ),
                       child: Material(
                         color: Colors.transparent,
                         child: InkWell(
                             onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => loginUi()),
                               );
                             },
                             child: Center(
                               child: Text('log in'.toUpperCase(),
                                   style: TextStyle(color: Colors.white,fontSize: 16)),
                             )),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 50,
                 ),
               ],
             ),
           ),
         ],
       )
      )
    );
  }

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
              child: Text('Full Name', style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
            Container(
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  hintText: 'Enter your first name here',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
                style: TextStyle(color: Colors.white, fontSize: 12.0),
                controller: fnameController,
                validator: (val){
                  if(val!.isEmpty){
                    return 'Please enter Name';
                  } else if(val.contains(RegExp(r'[0-9]'))){
                    return 'Please check your entry';
                  }
                },
                onSaved: (val)=> fname=val.toString(),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text('Last Name', style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
            Container(
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  hintText: 'Enter your last name here',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
                style: TextStyle(color: Colors.white, fontSize: 12.0),
                controller: lnameController,
                validator: (val){
                  if(val!.isEmpty){
                    return 'Please enter Name';
                  } else if(val.contains(RegExp(r'[0-9]'))){
                    return 'Please check your entry';
                  }
                },
                onSaved: (val)=> lname=val.toString(),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text('Email', style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
            Container(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  hintText: ' Type your email here',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
                style: TextStyle(color: Colors.white, fontSize: 12.0),
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
                onSaved: (val)=> email=val.toString(),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('Password', style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
            Container(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  hintText: 'Type your password here ',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
                style: TextStyle(color: Colors.white, fontSize: 12.0),
                controller: passwordController,
                validator:(val)=> validatePassword(val.toString()),
                onSaved: (val)=> password=val.toString(),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('Confirm Password', style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
            Container(
              height: 50,
              child:TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  hintText: 'Confirm your password here',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
                style: TextStyle(color: Colors.white, fontSize: 12.0),
                controller: correctPasswordController,
                validator:(val)=> validateConfirmPassword(val.toString()),
              ),
            )
          ],
        ),
      ),

    );
  }

  Widget _buildPopUp(BuildContext context){
    return AlertDialog(
      content: Text('Error', style: TextStyle(
        fontSize: 15,
        fontFamily: 'Montserrat',
      ),) ,
      actions: [
        FlatButton(
            color: Colors.black,
            onPressed: (){
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => Intro_Screen()
              // ));
            },
            child: Text('OK', style: TextStyle(
                fontSize: 15,
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),))
      ],
    );
  }

}
