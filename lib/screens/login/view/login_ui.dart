import 'package:flutter/material.dart';

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
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Text('Login', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30.0),),
            SizedBox(
              height: 50,
            ),
            Container(
              child: form(context),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 20),
              child:FlatButton(
                minWidth: double.infinity,
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    print(email);
                    print(password);
                    _scaffoldKey.currentState!.showSnackBar(
                        new SnackBar(
                          content: new Text(
                              "Success"),
                        ));

                  }
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
            )
          ],
        ),
      ),

    );
  }
  Widget form(BuildContext context){
    return new  Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(50, 0, 50, 30),
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
            child: Text('Email', style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            )),
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your Email'
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
          SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password '
            ),
            controller: passwordController,
            validator:(val)=> validatePassword(val.toString()),
            onSaved: (val)=> password=val.toString(),
          ),
        ],
      ),

    );
  }
}
