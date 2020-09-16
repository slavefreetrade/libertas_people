import 'package:flutter/material.dart';
import 'package:libertaspeople/global_widgets/our_drawer.dart';

class EmmanuelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OurDrawer(),
      appBar: AppBar(
        title: Text("Emmanuel's Page"),
      ),
      body: Center(child: Text("I am very happy when I work with you")),
    );
  }
}
