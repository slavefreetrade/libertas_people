import "package:flutter/material.dart";
import 'package:libertaspeople/constants/colors.dart';

class NoSurveyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
              height: 16,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(0),
              elevation: 0,
              color: ColorConstants.greyAboutPage,
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
