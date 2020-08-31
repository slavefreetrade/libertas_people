import 'package:flutter/material.dart';
import 'package:libertaspeople/global_widgets/our_drawer.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OurDrawer(),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text(
          'Are you guys ready?',
        ),
      ),
    );
  }
}
