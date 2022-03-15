import 'package:flutter/material.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/signup/api.dart';

class Notification_ui extends StatefulWidget {
  const Notification_ui({Key? key}) : super(key: key);

  @override
  _Notification_uiState createState() => _Notification_uiState();
}

class _Notification_uiState extends State<Notification_ui> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CallApi().fetchNotifictions();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context,int index){
              return Padding(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                child: Card(
                  color: ColorNames().ash,
                  child: Container(
                    height: 60,
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
                            Text('Notification Header',
                                style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                                style: TextStyle(color: Colors.black,fontSize: 9)),
                          ],
                        )


                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      bottomNavigationBar: Container(
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
      ),

    );
  }
}
