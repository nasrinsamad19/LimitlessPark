import 'package:flutter/material.dart';
import 'package:limitlesspark/screens/login/view/login_ui.dart';

class intro_ui extends StatefulWidget {
  const intro_ui({Key? key}) : super(key: key);

  @override
  _intro_uiState createState() => _intro_uiState();
}

class _intro_uiState extends State<intro_ui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Text('Hello There', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30.0),),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(50, 259, 50, 20),
              child:FlatButton(
                minWidth: double.infinity,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => loginUi()),
                  );
                },
                color: Colors.blue,
                child: Text('Login', style: TextStyle(
                    color: Colors.white
                )
                ),
                textColor: Colors.blue,
                shape: RoundedRectangleBorder(side: BorderSide(
                    color: Colors.blue,
                    width: 1,
                    style: BorderStyle.solid
                ), borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
              child:FlatButton(
                minWidth: double.infinity,
                onPressed: (){},
                color: Colors.blue,
                child: Text('Sign Up', style: TextStyle(
                    color: Colors.white
                )
                ),
                textColor: Colors.blue,
                shape: RoundedRectangleBorder(side: BorderSide(
                    color: Colors.blue,
                    width: 1,
                    style: BorderStyle.solid
                ), borderRadius: BorderRadius.circular(20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
