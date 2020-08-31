import 'package:flutter/material.dart';
import 'package:libertaspeople/global_widgets/our_drawer.dart';


class VipulsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vipul's Page"),
      ),
      drawer: OurDrawer(),
      body: Center(
        child: Text("Feeling great to be a part of this team!"),
      ),
    );
  }
}
