import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(),
    );
  }
}

Widget HomeScreen(){
  return Column(
    children: [
      Text("Splash screen"),
    ],
  );
}
