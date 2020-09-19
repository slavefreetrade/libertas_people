import 'package:flutter/material.dart';

class ProfileCreationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workplace Id')),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Container(
                color: Colors.green,
                child: Text('AnimatedProgressBar'),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                child: Text('Form'),
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.red,
                child: Text('ActionButtons'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
