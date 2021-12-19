import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/utils/authentication.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
  @override
  TextEditingController emailController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  final auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_back_ios,
                        color: ColorNames().darkBlue,
                        size: 15,
                      ),
                      Text(
                        'Forgot password',
                        style: TextStyle(
                            color: ColorNames().darkBlue, fontSize: 12.0),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: height / 3,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/lock.png',
                width: 150,
                height: 100,
              ),
            ),
            Text(
              'Forgot your',
              style: TextStyle(color: ColorNames().darkBlue, fontSize: 13.0),
            ),
            Text(
              'Password?',
              style: TextStyle(
                  color: ColorNames().darkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
            SizedBox(
              height: 50,
            ),
            emilform(context),
            SizedBox(
              height: 20,
            ),
            Container(
              height: height / 10,
              width: width / 1.5,
              padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, ColorNames().lightBlue]),
                  boxShadow: [],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        Authentication.initializeFirebase(context: context);
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          auth.sendPasswordResetEmail(email: email);
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Text('Submit',
                            style: TextStyle(color: Colors.white)),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emilform(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Container(
        height: 50,
        width: width / 2.5,
        child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorNames().darkBlue),
              borderRadius: BorderRadius.circular(20.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorNames().darkBlue),
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Enter your Email',
            hintStyle: TextStyle(color: ColorNames().darkBlue, fontSize: 10.0),
          ),
          controller: emailController,
          validator: (val) {
            Pattern pattern =
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
            RegExp regex = RegExp(pattern.toString());
            if (val!.isEmpty) {
              return 'Please enter email';
            } else {
              if (!regex.hasMatch(val)) {
                return 'Invalid Email';
              }
            }
          },
          onSaved: (val) => email = val.toString(),
        ),
      ),
    );
  }
}
