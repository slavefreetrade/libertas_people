import "package:flutter/material.dart";
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/colors.dart';

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
              S.of(context).yourSurveys,
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
              color: AppColors.greyAboutPage,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  S
                      .of(context)
                      .youHaveNoSurveysAtTheMomentWeWillNotifyYouWhenThereIsANewSurveyAvailable,
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
