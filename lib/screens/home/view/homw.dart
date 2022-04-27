import 'package:flutter/material.dart';
import 'package:limitlesspark/screens/activities/view/activities_ui.dart';
import 'package:limitlesspark/screens/book_now/view/book_now-ui.dart';
import 'package:limitlesspark/screens/common/app_constants.dart';
import 'package:limitlesspark/screens/notifiction/view/notification_ui.dart';
import 'package:limitlesspark/screens/profile/view/profile.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }

class Home extends StatelessWidget {
  int selectedPage;

  Home(this.selectedPage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: selectedPage,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: ColorNames().darkBlue,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(60.0),
                child: ColoredBox(
                  color: ColorNames().ash,
                  child: TabBar(
                    indicatorColor: ColorNames().grey,
                    indicatorWeight: 5,
                    tabs: [
                      Tab(
                        child: Text(
                          'Book Now',
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Activities',
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Profile',
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              title: Container(
                  alignment: Alignment.center,
                  color: ColorNames().darkBlue,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/limitless_logo.png',
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        'Limitless Parking'.toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 19.0),
                      ),
                    ],
                  ))),
          body: TabBarView(
            children: [
              BookNow(),
              Activities_ui(),
              ProfileUI(),
              Notification_ui(),

//SecondScreen(),
              //ThirdScreen()
            ],
          ),
        ),
      ),
    );
  }
}
