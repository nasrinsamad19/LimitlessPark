import 'package:flutter/material.dart';
import 'package:limitlesspark/screens/activities/model/model.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/signup/api.dart';

class Activities_ui extends StatefulWidget {
  const Activities_ui({Key? key}) : super(key: key);

  @override
  _Activities_uiState createState() => _Activities_uiState();
}

class _Activities_uiState extends State<Activities_ui> {
  bool noddata = false;
  late Future<Activities> futureData;
  List dataList = [];
  late List<Result> list;
  var next;
  var previous;
  int offest = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isFirstLoadRunning = true;
    });
    CallApi().fetchActivities('logs/list/?offset=0&limit=5').then((value) {
      if (value.results.length != 0) {
        print("no data");
        setState(() {
          noddata = true;
          next = value.next;
          previous = value.previous;
          dataList = value.results as List;
          print(dataList);
          list = dataList as List<Result>;
          print(list);
          _isFirstLoadRunning = false;
        });
      } else {
        setState(() {
          _isFirstLoadRunning = false;
          noddata = false;
        });
      }
    });
    _controller.addListener(() {
      setState(() {
        _isLoadMoreRunning == true;
      });
      if (_controller.position.pixels >= _controller.position.maxScrollExtent &&
          !_isFirstLoadRunning) {
        offest += 1;
        print('newdata');
        CallApi()
            .fetchActivities('logs/list/?offset=$offest&limit=5')
            .then((value) {
          if (value.results.isNotEmpty) {
            print("no data");
            setState(() {
              _isFirstLoadRunning = true;
              noddata = true;
              next = value.next;
              previous = value.previous;
              dataList.addAll(value.results as List);
              print(dataList);
              //list.add(dataList as List<Result>);
              //list = dataList as List<Result>;
              print(list);
              _isFirstLoadRunning = false;
            });
          } else {
            print('end');
            showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopUp(context));
            _hasNextPage == false;

            setState(() {
              print('end');

              _hasNextPage == false;
            });
          }
        });
      }
      setState(() {
        _isLoadMoreRunning == false;
      });
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  final ScrollController _controller = ScrollController();

  void _loadMore() {
    if (next == '') {
      setState(() {
        _hasNextPage = false; // Display a progress indicator at the bottom
      });
    } else if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      offest += 1; // Increase _page by 1

      CallApi()
          .fetchActivities('logs/list/?offset=$offest&limit=5')
          .then((value) {
        if (value.results != null) {
          if (value.next != null && value.results != null) {
            dataList.add(value.results as List);
          } else {
            setState(() {
              next = false;
            });
          }
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      });
      setState(() {
        _isLoadMoreRunning = false;
      });
    } else {
      setState(() {
        _hasNextPage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: _isFirstLoadRunning
            ? Center(
                child: CircularProgressIndicator(),
              )
            : noddata
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            controller: _controller,
                            itemCount: dataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Card(
                                  color: ColorNames().ash,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Stack(
                                      fit: StackFit.passthrough,
                                      overflow: Overflow.visible,
                                      children: [
                                        // Positioned(
                                        //     right: 0,
                                        //     child: Row(
                                        //       children: [
                                        //         Icon(Icons.access_time,
                                        //             size: 9, color: Colors.grey),
                                        //         Text('',
                                        //             style: TextStyle(
                                        //               color: Colors.grey,
                                        //               fontSize: 9,
                                        //             )),
                                        //       ],
                                        //     )),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Parking details',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Arrival',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: width / 3,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                        // gradient: LinearGradient(
                                                        //     colors: [Colors.blue, ColorNames().lightBlue]),
                                                        // color: ColorNames().darkBlue,
                                                        boxShadow: [],
                                                        border: Border.all(
                                                            color: ColorNames()
                                                                .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                          dataList[index]
                                                              .arrival
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 9)),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Departure',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: width / 3,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                        // gradient: LinearGradient(
                                                        //     colors: [Colors.blue, ColorNames().lightBlue]),
                                                        // color: ColorNames().darkBlue,
                                                        boxShadow: [],
                                                        border: Border.all(
                                                            color: ColorNames()
                                                                .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                          dataList[index]
                                                              .departure
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 9)),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Car',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: width / 3,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                        // gradient: LinearGradient(
                                                        //     colors: [Colors.blue, ColorNames().lightBlue]),
                                                        // color: ColorNames().darkBlue,
                                                        boxShadow: [],
                                                        border: Border.all(
                                                            color: ColorNames()
                                                                .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                          dataList[index]
                                                              .licensePlate,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 9)),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Cost',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: width / 3,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                        // gradient: LinearGradient(
                                                        //     colors: [Colors.blue, ColorNames().lightBlue]),
                                                        // color: ColorNames().darkBlue,
                                                        boxShadow: [],
                                                        border: Border.all(
                                                            color: ColorNames()
                                                                .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                          dataList[index].cost,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 9)),
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
                            }),
                      ),
                      // when the _loadMore function is running
                      if (_isLoadMoreRunning == true)
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 40),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      if (_hasNextPage == false)
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          color: ColorNames().blue,
                          child: Center(
                            child: Text('You have fetched all of the content'),
                          ),
                        ),
                    ],
                  )
                : Center(
                    child: Text('No Activities'),
                  )

        // bottomNavigationBar: noddata
        //       ? Container(
        //           child: Container(
        //             height: height / 10,
        //             width: width / 1.5,
        //             padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 // gradient: LinearGradient(
        //                 //     colors: [Colors.blue, ColorNames().lightBlue]),
        //                 color: ColorNames().darkBlue,
        //                 boxShadow: [],
        //                 borderRadius: BorderRadius.circular(5),
        //               ),
        //               child: Material(
        //                 color: Colors.transparent,
        //                 child: InkWell(
        //                     onTap: () {},
        //                     child: Center(
        //                       child: Text('LOAD MORE',
        //                           style: TextStyle(color: Colors.white)),
        //                     )),
        //               ),
        //             ),
        //           ),
        //         )
        //       : Container(),
        );
  }

  Widget _buildPopUp(BuildContext context) {
    return AlertDialog(
      content: Text(
        'You have fetched all of the content',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Montserrat',
        ),
      ),
      actions: [
        FlatButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
