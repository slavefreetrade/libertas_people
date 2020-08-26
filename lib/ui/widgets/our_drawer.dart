import 'package:flutter/material.dart';
import 'package:libertaspeople/ui/pages/emmanuels_page.dart';
import 'package:libertaspeople/ui/pages/home_page.dart';
import 'package:libertaspeople/ui/pages/michaels_page.dart';
import 'package:libertaspeople/ui/pages/peters_page.dart';
import 'package:libertaspeople/ui/pages/souviks_page.dart';

class OurDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset("assets/slavefreetrade.png"),
          ),
          ListTile(
            title: Text("Home Page"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Peter's Page"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PetersPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Souvik's Page"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SouviksPage(),
            title: Text("Emmanuel's Page"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EmmanuelsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Michael's Page"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MichaelsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
