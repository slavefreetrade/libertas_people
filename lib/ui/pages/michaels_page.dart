import 'package:flutter/material.dart';
import 'package:libertaspeople/ui/widgets/our_drawer.dart';

class MichaelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OurDrawer(),
      appBar: AppBar(
        title: Text("Michael's Page"),
      ),
       body: Center(child: Text("I am very excited to be working with you :)")),
    );
  }
}
