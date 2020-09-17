import 'package:flutter/material.dart';
import 'package:libertaspeople/todo_practice_work/global_widgets/our_drawer.dart';

class SouviksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Souvik's Page"),
      ),
      drawer: OurDrawer(),
      body: Center(
        child: Text("e=mc^2"),
      ),
    );
  }
}
