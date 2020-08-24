import 'package:flutter/material.dart';
import 'package:libertaspeople/ui/widgets/our_drawer.dart';

class PetersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OurDrawer(),
      appBar: AppBar(
        title: Text("Peter's Page"),
      ),
       body: Center(child: Text("I look forward to working with all of you!")),
    );
  }
}
