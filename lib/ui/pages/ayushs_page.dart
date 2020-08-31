import 'package:flutter/material.dart';
import 'package:libertaspeople/global_widgets/our_drawer.dart';

class AyushsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OurDrawer(),
      appBar: AppBar(title: Text('Ayush\'s Page')),
      body: Center(
        child: Text('Looking forward to working and learning from you all'),
      ),
    );
  }
}
