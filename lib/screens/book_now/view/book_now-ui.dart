import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/signup/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookNow extends StatefulWidget {
  const BookNow({Key? key}) : super(key: key);

  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {

  TextEditingController dateinputarrival = TextEditingController();
  TextEditingController dateinputDeparture = TextEditingController();
  //String _selectedDate1=DateFormat.yMd().add_jm().format(DateTime.now());
  //String _selectedDate1=DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now().t);
  String _selectedDate1 = DateTime.now().toIso8601String();
  String _selectedDate2 = 'Pick A date';


  Future<void> _selectDate1(BuildContext context) async {
    final  d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2032),
    );
    if (d != null)
      setState(() {
        _selectedDate1 = new DateFormat.yMd("en_US").format(d);
      });
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2032),
    );
    if (d != null)
      setState(() {
        _selectedDate2 = new DateFormat.yMd("en_US").format(d);
      });
  }


  String? dropdownvalue;
  // List of items in our dropdown menu
  var items = [
    '5467',
    '7687'
  ];
  getCars() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cars = prefs.getStringList('cars');
    //final List<Map<String, Object>> items = cars!.map((item) => jsonEncode(item)).cast<Map<String, Object>>().toList();
    print('llllllllll');
  }
  @override
  void initState() {
    // TODO: implement initState
    dateinputarrival.text = _selectedDate1;
    dateinputDeparture.text=_selectedDate1;
    super.initState();
    getCars();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 50,right: 50,top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Arrival', style: TextStyle(color: Colors.black,fontSize: 15.0),),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide( color: ColorNames().grey),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide( color: ColorNames().grey),
                  ),
                  hintText: DateTime.now().toString(),
                  hintStyle: TextStyle(color: ColorNames().grey, fontSize: 10.0),
                ),
                style: TextStyle(color: ColorNames().grey, fontSize: 12.0),
                controller: dateinputarrival,
                //initialValue: _selectedDate1,
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
                //onSaved: (input)=> loginRequestModel.email= input.toString(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Departure', style: TextStyle(color: Colors.black,fontSize: 15.0),),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide( color: ColorNames().grey),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide( color: ColorNames().grey),
                  ),
                  hintText: DateTime.now().toString(),
                  hintStyle: TextStyle(color: ColorNames().grey, fontSize: 10.0),
                ),
                style: TextStyle(color: ColorNames().grey, fontSize: 12.0),
                controller: dateinputDeparture,
                //initialValue: _selectedDate1,
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
                //onSaved: (input)=> loginRequestModel.email= input.toString(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Car', style: TextStyle(color: Colors.black,fontSize: 15.0),),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              width: width/3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: ColorNames().grey),
              ),
              padding: EdgeInsets.all(8),
              child: DropdownButton(
                isExpanded: true,
                borderRadius: BorderRadius.circular(5),
                underline: Container(),
                style: TextStyle(color: Colors.black,fontSize: 12),

                // Initial Value
                value: dropdownvalue,
                hint: Text('Select your car',
                    style: TextStyle(color: ColorNames().grey,fontSize: 12)),

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),

            )
          ],
        )
      ),
      bottomNavigationBar: Container(
        child:  Container(
          height: 50,
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
                    _bookNow();

                  },
                  child: Center(
                    child: Text('BOOK NOW',
                        style: TextStyle(color: Colors.white)),
                  )),
            ),
          ),
        ),
      ),

    );
  }
  _bookNow(){

    //var arrival= DateFormat().parse(dateinputarrival.text).toIso8601String();
    //var departure= DateFormat().parse(dateinputDeparture.text).toIso8601String();

    print(dateinputarrival.text);
   // print(arrival);


    var data={
        "arrival": dateinputarrival.text,
        "departure": dateinputarrival.text,
        "license_plate": dropdownvalue.toString(),
    };

    CallApi().postBookNow(data,'reservations/').then((value){
      if(value == true){
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Home()),
        // );
        print('sucees');
      }
      else{
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) => _buildPopUp(context)
        //
        // );
        print('errorrr');

      }
    });
  }
}
