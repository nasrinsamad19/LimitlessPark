import 'package:flutter/material.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/home/view/homw.dart';
import 'package:limitlesspark/screens/signup/api.dart';

class CarRegistartionUi extends StatefulWidget {
  const CarRegistartionUi({Key? key}) : super(key: key);

  @override
  _CarRegistartionUiState createState() => _CarRegistartionUiState();
}

class _CarRegistartionUiState extends State<CarRegistartionUi> {

  TextEditingController car1Controller = TextEditingController();
  TextEditingController car2Controller = TextEditingController();

  _registerCar(){
    var data={
      'license_plate': car1Controller.text,
    };

    CallApi().postCarRegistration(data,'cars/create/').then((value){
      if(value == true){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
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
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide( color: ColorNames().grey),
                                ),
                                hintText: 'License plate no.',
                                hintStyle: TextStyle(color: ColorNames().darkgrey, fontSize: 14.0),
                              ),
                              controller: car1Controller,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'Please enter Name';
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
                              decoration: InputDecoration(
                                fillColor: ColorNames().blue,
                                hintText: 'license plate no.',
                                hintStyle: TextStyle(color: ColorNames().darkgrey, fontSize: 14.0),
                              ),
                              controller: car2Controller,
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
                          onTap: () {
                            _registerCar();
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
