import 'package:flutter/material.dart';
import 'package:libertaspeople/pages/emmanuel_work/splash_screen.dart';

import 'emmanuel_work/widgets/custom_form.dart';
import 'package:libertaspeople/pages/home/home_page.dart';

class UIDevelopmentPage extends StatefulWidget {
  @override
  _UIDevelopmentPageState createState() => _UIDevelopmentPageState();
}

class _UIDevelopmentPageState extends State<UIDevelopmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("splash screen"),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                      return new SplashScreen();
                    }));
              },
            ),
            ListTile(
              title: Text("onboarding"),
              onTap: () {
                print("nav to onboarding 1 page");
              },
            ),
            ListTile(
              title: Text("create profile"),
              onTap: () {
                print("nav to create profile page");
              },
            ),
            ListTile(
              title: Text("feat-profile creation"),
              onTap: () {
                print("nav to workplace id page");
              },
            ),
            ListTile(
              title: Text("confirmation login_returning user"),
              onTap: () {
                print("nav to confirmation login_returning user page");
              },
            ),
            ListTile(
              title: Text("home_first time user"),
              onTap: () {
                print("nav to home_first time user page");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainHomePage(
                        num: 1,
                      );
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text("home_first no surveys"),
              onTap: () {
                print("nav to home_first no surveys page");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainHomePage(
                        num: 2,
                      );
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text("home_returning user"),
              onTap: () {
                print("nav to home_returning user page");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainHomePage(
                        num: 3,
                      );
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text("profile screen"),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return CustomForm();
                }));
              },
            ),
            ListTile(
              title: Text("profile screen #5"),
              onTap: () {
                print("nav to profile screen #5 page");
              },
            ),
            ListTile(
              title: Text("survey language"),
              onTap: () {
                print("nav to survey language page");
              },
            ),
            ListTile(
              title: Text("survey information"),
              onTap: () {
                print("nav to survey information page");
              },
            ),
            ListTile(
              title: Text("survey Q1"),
              onTap: () {
                print("nav to survey Q1 page");
              },
            ),
            ListTile(
              title: Text("survey1 thank you"),
              onTap: () {
                print("nav to survey1 thank you page");
              },
            ),
            ListTile(
              title: Text("thank you screen retr=u"),
              onTap: () {
                print("nav to _ page");
              },
            ),
            ListTile(
              title: Text("about - before user fill survey"),
              onTap: () {
                print("nav to _ page");
              },
            ),
          ],
        ));
  }
}
