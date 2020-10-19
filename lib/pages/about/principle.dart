import 'package:flutter/material.dart';

class Principle extends StatelessWidget {
  final String logo;
  final String title;
  final String text;

  Principle({this.logo, this.title, this.text});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Principle"),
        ),
        body: Container(
            width: width,
            height: height,
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image(
                        image: AssetImage(logo),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: width * 0.6,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 26.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                  child: Container(
                    child: Text(
                      text,
                      style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'Helvetica Neue',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            )));
  }
}
