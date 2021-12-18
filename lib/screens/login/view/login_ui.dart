import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/login/view/sample.dart';
import 'package:limitlesspark/screens/signup/signup_ui.dart';
import 'package:limitlesspark/utils/authentication.dart';

class loginUi extends StatefulWidget {
  const loginUi({Key? key}) : super(key: key);

  @override
  _loginUiState createState() => _loginUiState();
}

class _loginUiState extends State<loginUi> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String email='';
  String password='';

  @override
  void initState() {
    super.initState();
    Authentication.initializeFirebase(context: context).whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

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

  

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.only(top: 50),
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
                      Text('Log in', style: TextStyle(color: Colors.white,fontSize: 15.0),),
                    ],
                  ),
                )
              ),
              SizedBox(
                height: 100,
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

              SizedBox(
                height: 20,
              ),
              Container(
                child: loginForm(context),
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: Text('Forgot your password?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignUp()),
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => loginUi()),
                            // );
                          },
                          child: Center(
                            child: Text('Log In',
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
                      Text('Login with one of the following', style: TextStyle(color: Colors.white, fontSize: 13.0),),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ColorNames().lightBlue,
                                Colors.blue
                              ]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:  () async {
                                  Authentication.initializeFirebase(context: context);
                                  User? user =
                                      await Authentication.signInWithGoogle(context: context);
                                  if (user != null) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => UserInfoScreen(
                                          user: user,
                                        ),
                                      ),
                                    );
                                  }

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
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ColorNames().lightBlue,
                                Colors.blue
                              ]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => loginUi()),
                                  // );
                                },
                                child: Image.asset(
                                  'assets/images/apple_icon.png',
                                  width: 30,
                                  height: 30,
                                ),),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ColorNames().lightBlue,
                                Colors.blue
                              ]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                FacebookAuth.instance.login(permissions: ["public_profile", "email"]).then((value) {
                                  FacebookAuth.instance.getUserData().then((
                                      userData) {
                                    print(userData);
                                  });
                                });
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
              SizedBox(height: 50,),
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
                          text: 'Don\'t  have an account?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.0),
                        ),
                        TextSpan(
                          text: 'Sign up',
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
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
  Widget loginForm(BuildContext context){
    return new  Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(50, 0, 50, 30),
        children: [
          Container(
            alignment: Alignment.topLeft,
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
            child:TextFormField(
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
          )
        ],
      ),

    );
  }
}
