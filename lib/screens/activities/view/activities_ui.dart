import 'package:flutter/material.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/signup/api.dart';

class Activities_ui extends StatefulWidget {
  const Activities_ui({Key? key}) : super(key: key);

  @override
  _Activities_uiState createState() => _Activities_uiState();
}

class _Activities_uiState extends State<Activities_ui> {

bool noddata = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CallApi().fetchActivities().then((value) {
      if(value.body == null){
        print("no data");
        noddata = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: noddata?ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Card(
                color: ColorNames().ash,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    fit: StackFit.passthrough,
                    overflow: Overflow.visible,
                    children: [
                      Positioned(
                          right: 0,
                          child: Row(
                            children: [
                              Icon(Icons.access_time,size: 9,color: Colors.grey),
                              Text('12:00 AM',
                                  style: TextStyle(color: Colors.grey,fontSize: 9,)),
                            ],
                          )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Parking details',
                              style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Arrival',
                                      style: TextStyle(color: Colors.black,fontSize: 13)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width/4,
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      // gradient: LinearGradient(
                                      //     colors: [Colors.blue, ColorNames().lightBlue]),
                                     // color: ColorNames().darkBlue,
                                      boxShadow: [],
                                      border: Border.all(color: ColorNames().grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:  Text('12/02/2022 12:00AM',
                                        style: TextStyle(color: ColorNames().grey,fontSize: 9)),
                                  )
                                  
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Departure',
                                      style: TextStyle(color: Colors.black,fontSize: 13)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width/4,
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      // gradient: LinearGradient(
                                      //     colors: [Colors.blue, ColorNames().lightBlue]),
                                      // color: ColorNames().darkBlue,
                                      boxShadow: [],
                                      border: Border.all(color: ColorNames().grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:  Text('12/02/2022 12:00AM',
                                        style: TextStyle(color: ColorNames().grey,fontSize: 9)),
                                  )

                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Car',
                                      style: TextStyle(color: Colors.black,fontSize: 13)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width/4,
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      // gradient: LinearGradient(
                                      //     colors: [Colors.blue, ColorNames().lightBlue]),
                                      // color: ColorNames().darkBlue,
                                      boxShadow: [],
                                      border: Border.all(color: ColorNames().grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:  Text('S20265',
                                        style: TextStyle(color: ColorNames().grey,fontSize: 9)),
                                  )

                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Cost',
                                      style: TextStyle(color: Colors.black,fontSize: 13)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width/4,
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      // gradient: LinearGradient(
                                      //     colors: [Colors.blue, ColorNames().lightBlue]),
                                      // color: ColorNames().darkBlue,
                                      boxShadow: [],
                                      border: Border.all(color: ColorNames().grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:  Text('100.00AED',
                                        style: TextStyle(color: ColorNames().grey,fontSize: 9)),
                                  )

                                ],
                              )
                            ],
                          )

                        ],
                      )


                    ],
                  ),
                ),
              ),
            );
          }
      ):Center(child: Text('NO DATA'),),
      bottomNavigationBar: noddata?Container(
        child:  Container(
          height: height / 10,
          width: width / 1.5,
          padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
          child: Container(
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     colors: [Colors.blue, ColorNames().lightBlue]),
              color: ColorNames().darkBlue,
              boxShadow: [],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {

                  },
                  child: Center(
                    child: Text('LOAD MORE',
                        style: TextStyle(color: Colors.white)),
                  )),
            ),
          ),
        ),
      ):Container(),

    );
  }
}
