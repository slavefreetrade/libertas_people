import "package:flutter/material.dart";
import 'package:libertaspeople/constants/colors.dart';

class NoSurvey extends StatelessWidget {
  final deviceWidth;
  NoSurvey({this.deviceWidth});
  @override
  Widget build(BuildContext context) {
    print("deviceWidth is $deviceWidth");
    return Container(
      width: deviceWidth,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your surveys",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(0),
              elevation: 0,
              color: ColorConstants.greyHomePage,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "You have no surveys at the moment. We will notify you when there is a new survey available.",
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
