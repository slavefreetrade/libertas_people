import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';

class WelcomeBack extends StatelessWidget {
  final deviceWidth;
  WelcomeBack({this.deviceWidth});
  @override
  Widget build(BuildContext context) {
    print("deviceWidth is $deviceWidth");
    return Container(
      height: 200,
      width: deviceWidth,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: ColorConstants.greyHomePage,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      child: Image.asset('assets/icons/Group 129.png'),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Your monthly survey with 10 binary questions is ready.",
                              softWrap: true,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
