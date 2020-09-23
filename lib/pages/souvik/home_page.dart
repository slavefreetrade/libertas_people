import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_page_content/widget1.dart';
import 'home_page_content/widget2.dart';
import 'home_page_content/widget3.dart';
import '../../constants/colors.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int pageIndex = 0;
  List<Widget> tabPages = [
    HomepageFirstTimeUser(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorConstants.darkBlue,
        backgroundColor: ColorConstants.greyAboutPage,
        onTap: (ind) {
          setState(() {
            pageIndex = ind;
          });
        },
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text("About Survey"),
          ),
        ],
      ),
      body: tabPages[pageIndex],
    );
  }
}

class HomepageFirstTimeUser extends StatelessWidget {
  final theme = ThemeData();
  final String coverImage =
      "assets/woman-falling-in-line-holding-each-other-1206059 1.jpg"; //really big name so i thought making a variable would be better.
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        child: ListView(
          children: [
            Container(
              width: deviceWidth,
              child: Image.asset(coverImage),
            ),
            Container(
              height: (deviceWidth / 375) * 73.89,
              width: deviceWidth,
              color: ColorConstants.darkBlue,
              child: Center(
                child: Text(
                  "Libertas People",
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              width: deviceWidth,
              child: Welcome(),
            ),
            Container(
              height: 50,
              width: 50,
              child: FlatButton(
                onPressed: () {
                  print("Fetching Surveys");
                },
                child: Text(
                  "Take Survey",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                color: ColorConstants.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
