
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/login/view/login_ui.dart';


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
    print(passwordController.text);
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
        padding: EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/plain_background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
       child: Stack(
         children: [
           GestureDetector(
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
                     child:                    Icon(Icons.arrow_back_ios,color: Colors.white,size: 15, ),

                   ),
                   Text('Sign up', style: TextStyle(color: Colors.white,fontSize: 15.0),),
                 ],
               ),
             )

           ),
           SingleChildScrollView(
             physics: ClampingScrollPhysics(),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(
                   height: 80,
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
                   height: 50,
                 ),
                 Align(
                   alignment: Alignment.center,
                   child:Container(
                     height: height/12,
                     width: width/2,
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
                                 _scaffoldKey.currentState!.showSnackBar(
                                     new SnackBar(
                                       content: new Text(
                                           "Success"),
                                     ));
                               }
                             },
                             child: Center(
                               child: Text('Sign Up',
                                   style: TextStyle(color: Colors.white)),
                             )),
                       ),
                     ),
                   ),
                 ),
                 Align(
                   alignment: Alignment.bottomCenter,
                   child: GestureDetector(
                     child: RichText(
                       text: new TextSpan(
                         style: new TextStyle(
                           fontSize: 14.0,
                           color: Colors.black,
                         ),
                         children: <TextSpan>[
                           new TextSpan(
                             text: 'Already have an account?',
                             style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 11.0),
                           ),
                           TextSpan(
                             text: 'Log in',
                             style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 11.0,
                                 fontWeight: FontWeight.bold),
                           ),
                         ],
                       ),
                     ),
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => loginUi()),
                       );
                     },
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
              child: Text('First Name', style: TextStyle(
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
                  hintText: 'Enter your First Name',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
                controller: fnameController,
                validator: (val){
                  if(val!.isEmpty){
                    return 'Please enter First Name';
                  } else if(val.contains(RegExp(r'[0-9]'))){
                    return 'Please check your entry';
                  }
                },
                onSaved: (val)=> fname=val.toString(),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('Last Name', style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
            Container(
              height: 30,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  hintText: 'Enter your Last Name',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
                controller: lnameController,
                validator: (val){
                  if(val!.isEmpty){
                    return 'Please enter Last Name';
                  } else{
                    if(val.contains(RegExp(r'[0-9]'))){
                      return 'Please check your entry';
                    }
                  }
                },
                onSaved: (val)=> lname=val.toString(),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('Plate No', style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
            Container(
              height: 30,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  hintText: 'Enter your Plate Number',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
                controller: palteNoController,
                validator: (val){
                  if(val!.isEmpty){
                    return 'Please enter Plate Number';
                  } else{
                    if(val.contains(RegExp(r'[A-Z]'))){
                      return 'Please check your entry';
                    }
                  }
                },
                onSaved: (val)=> plateNo=val.toString(),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('Phone No', style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
            Container(
                height: 40,
                padding: EdgeInsets.only(top: 5),
                child:IntlPhoneField(
                  countryCodeTextColor: Colors.white,
                  keyboardType: TextInputType.number,
                  dropDownIcon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                  style: TextStyle(color: Colors.white,),
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    helperStyle: TextStyle(
                      color: Colors.white
                    ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide( color: Colors.white),
                    ),
                  ),
                  initialCountryCode: 'AE',
                  controller: phoneNoController,
                  onChanged: (phone) {
                    print(phone.countryISOCode);
                  },
                )
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('Email', style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
            ),
            Container(
              height: 30,
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  hintText: 'Enter your Email',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
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
              height: 30,
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  hintText: 'Enter your password ',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
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
              height: 30,
              child:TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  hintText: 'Enter your password ',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
                controller: correctPasswordController,
                validator:(val)=> validateConfirmPassword(val.toString()),
              ),
            )
          ],
        ),
      ),

    );
  }

}
