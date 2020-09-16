import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("onboarding 1"),
              onTap: () {
                print("nav to onboarding 1 page");
              },
            ),
            ListTile(
              title: Text("onboarding 2"),
              onTap: () {
                print("nav to onboarding 2 page");
              },
            ),
            ListTile(
              title: Text("onboarding 3"),
              onTap: () {
                print("nav to onboarding 3 page");
              },
            ),
            ListTile(
              title: Text("create profile"),
              onTap: () {
                print("nav to create profile page");
              },
            ),
            ListTile(
              title: Text("workplace id"),
              onTap: () {
                print("nav to workplace id page");
              },
            ),
            ListTile(
              title: Text("gender"),
              onTap: () {
                print("nav to gender page");
              },
            ),
            ListTile(
              title: Text("workplace"),
              onTap: () {
                print("nav to workplace page");
              },
            ),
            ListTile(
              title: Text("address"),
              onTap: () {
                print("nav to address page");
              },
            ),
            ListTile(
              title: Text("age"),
              onTap: () {
                print("nav to age page");
              },
            ),
            ListTile(
              title: Text("role"),
              onTap: () {
                print("nav to role page");
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
              },
            ),
            ListTile(
              title: Text("home_first no surveys"),
              onTap: () {
                print("nav to home_first no surveys page");
              },
            ),
            ListTile(
              title: Text("home_returning user"),
              onTap: () {
                print("nav to home_returning user page");
              },
            ),
            ListTile(
              title: Text("profile screen"),
              onTap: () {
                print("nav to profile screen page");
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
