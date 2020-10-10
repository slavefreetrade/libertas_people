import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_page_content/widget1.dart';
import 'home_page_content/widget2.dart';
import 'home_page_content/widget3.dart';
import '../../constants/colors.dart';

// new implementation
class MainHomePage extends StatefulWidget {
  final num;

  MainHomePage({this.num});

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int pageIndex = 0;

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
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About Survey",
          ),
        ],
      ),
//      body: tabPages[pageIndex],
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    "assets/woman-falling-in-line-holding-each-other-1206059 1.jpg"),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 50,
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
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                // only display one of these widgets
                if (widget.num == 1)
                  Welcome()
                else if (widget.num == 2)
                  NoSurvey()
                else
                  WelcomeBack(),
              ],
            ),
          ),
          if (widget.num != 2)
            Padding(
              padding: EdgeInsets.fromLTRB(55, 0.0, 65, 55),
              child: Container(
                height: 50,
                width: 300,
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
            ),
        ],
      ),
    );
  }
}

// Your previous implementation
//i am leaving this here since if we are to make use
//of bottom navigation bar we might need this.
class HomepageFirstTimeUser extends StatelessWidget {
  final num;

  HomepageFirstTimeUser({this.num});

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
            if (num == 1)
              Container(
                child: Welcome(
//                  deviceWidth: deviceWidth,
                    ),
              ),
            if (num == 2)
              Container(
                child: NoSurvey(
                  deviceWidth: deviceWidth,
                ),
              ),
            if (num == 3)
              Container(
                child: WelcomeBack(
                  deviceWidth: deviceWidth,
                ),
              ),
            if (num != 2)
              Padding(
                padding: EdgeInsets.fromLTRB(55, 0.0, 65, 55),
                child: Container(
                  height: 50,
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
              ),
          ],
        ),
      ),
    );
  }
}
