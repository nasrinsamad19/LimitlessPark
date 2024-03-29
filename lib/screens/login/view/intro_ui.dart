import 'package:flutter/material.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/login/view/login_ui.dart';
import 'package:limitlesspark/screens/signup/signup_ui.dart';

class intro_ui extends StatefulWidget {
  const intro_ui({Key? key}) : super(key: key);

  @override
  _intro_uiState createState() => _intro_uiState();
}

class _intro_uiState extends State<intro_ui> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/intro_background.jpeg"),
          fit: BoxFit.fill,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height / 2.5,
            ),
            Image.asset(
              'assets/images/limitless_logo.png',
              width: 150,
              height: 100,
            ),
            Text(
              'Welcome to the',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0),
            ),
            Text(
              'Limitless Park',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => loginUi()),
                        );
                      },
                      child: Center(
                        child: Text('Log In',
                            style: TextStyle(color: Colors.white)),
                      )),
                ),
              ),
            ),

            Container(
              height: height/12,
              width: width/2,
              padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blue,
                      ColorNames().lightBlue
                    ]),
                    boxShadow: [],
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
                        child: Text('Sign Up',
                            style: TextStyle(color: Colors.white)),
                      )),
                ),
              ),
            ),
            GestureDetector(
              child: RichText(
                text: new TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                      text: 'Forgot your password?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0),
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
            )
          ],
        ),
      ),
    ));
  }
}
