import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  static const String PlaceHolderLogoImage = 'assets/slavefreetrade_logo.png';
  static const String placeholdLogoText = "assets/slavefreetrade_logo_text.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: HomeScreen(placeHolderImage: PlaceHolderLogoImage, placeholdLogoText: placeholdLogoText),
    );
  }
}

Widget HomeScreen({String placeHolderImage, String placeholdLogoText}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 175.0,
            width: 175.0,
                child: Image.asset(placeHolderImage),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50.0,
            width: 250.0,
                child: Image.asset(placeholdLogoText),
          ),
        ],
      ),

    ],
  );
}
