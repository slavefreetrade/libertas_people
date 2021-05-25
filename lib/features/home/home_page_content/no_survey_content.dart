import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../../shared_ui_elements/colors.dart';

class NoSurveyContent extends StatelessWidget {
  const NoSurveyContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).yourSurveys,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(0),
          elevation: 0,
          color: AppColors.greyAboutPage,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              S
                  .of(context)
                  .youHaveNoSurveysAtTheMomentWeWillNotifyYouWhenThereIsANewSurveyAvailable,
              softWrap: true,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
