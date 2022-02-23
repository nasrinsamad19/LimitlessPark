import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:limitlesspark/screens/car_registration/view/car_registration_ui.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/home/view/homw.dart';
import 'package:limitlesspark/screens/login/view/model.dart';
import 'package:limitlesspark/screens/login/view/reset_password.dart';
import 'package:limitlesspark/screens/login/view/sample.dart';
import 'package:limitlesspark/screens/signup/api.dart';
import 'package:limitlesspark/screens/signup/signup_ui.dart';
import 'package:limitlesspark/utils/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginUi extends StatefulWidget {
  const loginUi({Key? key}) : super(key: key);

  @override
  _loginUiState createState() => _loginUiState();
}
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class _loginUiState extends State<loginUi> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String email='';
  String password='';
  var id;
  var acessToken;
  var idToken;


  late LoginRequestModel loginRequestModel;

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel(email: '',password: '');
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

  bool _isloading = false;

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
                      SizedBox(width: 80,),
                      Text('Log into your account'.toUpperCase(), style: TextStyle(color: Colors.white,fontSize: 15.0),),
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
                  child: Text('Forgot your password?'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPassword()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child:Container(
                  height: height/12,
                  width: width/1.6,
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
                            if(validateAndSave()){

                              CallApi callApi = new CallApi();
                              callApi.login(loginRequestModel).then((value) async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                var cars = prefs.getStringList('cars');
                                if(cars!.isNotEmpty){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                }
                                else{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CarRegistartionUi()),
                                  );
                                }
                              });
                              print(loginRequestModel.toJson());
                            }
                           },
                          child: Center(
                            child: Text('Log In'.toUpperCase(),
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
                             border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:  () async {
                                  var _token;
                                  Authentication.initializeFirebase(context: context);
                                  User? user =
                                      await Authentication.signInWithGoogle(context: context);
                                  var value = Authentication.signgoogle(context: context);
                                  if (value != null) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => CarRegistartionUi(
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
                                FacebookAuth.instance.login(permissions: ["public_profile", "email"]).then((value) async {
                                  // Create a credential from the access token
                                  final OAuthCredential credential = FacebookAuthProvider.credential(value.accessToken!.token);
                                  acessToken= credential.accessToken;
                                  var cr= FirebaseAuth.instance.signInWithCredential(credential).then((value){
                                    id = credential.idToken;
                                    idToken = value.user!.getIdToken();
                                    idToken.then((value){
                                      id =value;
                                      signfacebook();
                                    });
                                  });
                                 //  print(cr.then((value){
                                 //    idToken = value!.user!.getIdToken();
                                 //     idToken.then((value) {
                                 //       id= value;
                                 //       print(id);
                                 //       print(acessToken);
                                 //       signfacebook();
                                 //     });
                                 // }));
                                 //aacessToken= value.accessToken!.token;
                                 //               print('ppppppp');
                                 //  print(value.accessToken!.token);
                                 //  print(value.accessToken!.applicationId);
                                 //  print(credential.accessToken);
                                 //  print('ppppppp');
                                 // print(credential.idToken);
                                 //   FacebookAuth.instance.accessToken;
                                    FacebookAuth.instance.getUserData().then((
                                      userData) {
                                    print(userData);
                                    if (userData != null) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => CarRegistartionUi(
                                          ),
                                        ),
                                      );
                                    }

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
                child: Text(
                  'Don\'t  have an account?'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.center,
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
                          onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUp()),
                              );
                          },
                          child: Center(
                            child: Text('sign up'.toUpperCase(),
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
                hintText: 'Type your email here',
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
              onSaved: (input)=> loginRequestModel.email= input.toString(),
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
                hintText: 'Type your password here',
                hintStyle: TextStyle(color: Colors.white, fontSize: 10.0),
              ),
              style: TextStyle(color: Colors.white, fontSize: 12.0),
              controller: passwordController,
              validator:(val)=> validatePassword(val.toString()),
              onSaved: (input)=> loginRequestModel.password= input.toString(),
            ),
          )
        ],
      ),

    );
  }

  bool validateAndSave(){
    final form = _formKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;
  }

   signfacebook(){
    var data={
      'access_token': acessToken.toString(),
      'code': '',
      'id_token' : id,
    };
    CallApi().postSocialFacebbokLogin(data,'accounts/social-login/facebook/').then((value){
      if(value == true){
        return true;
      }
      else{
        return false;
      }
    });
  }

}
