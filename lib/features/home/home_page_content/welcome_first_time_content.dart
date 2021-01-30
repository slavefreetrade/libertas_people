import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../../shared_ui_elements/colors.dart';
import '../../../shared_ui_elements/images.dart';

import '../../survey/lauguage_selection_page.dart';

class WelcomeFirstTimeContent extends StatefulWidget {
  final String firstSurveyId;

  const WelcomeFirstTimeContent({Key key, @required this.firstSurveyId})
      : super(key: key);

  @override
  _WelcomeFirstTimeContentState createState() =>
      _WelcomeFirstTimeContentState();
}

class _WelcomeFirstTimeContentState extends State<WelcomeFirstTimeContent> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).welcomeOnboard,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              S
                  .of(context)
                  .weAreHappyThatYouWantToTakePartInOurSurveyThatPlaysAnImportantPartIn,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
            ),
            const SizedBox(
              height: 13,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Image.asset(AppImages.ima),
                        ),
                        Text(
                          S.of(context).alwaysAnonymous,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Image.asset(AppImages.i),
                      ),
                      Text(
                        S.of(context).onlyBinaryQuestions,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Image.asset(AppImages.im),
                      ),
                      Flexible(
                        child: Text(
                          S.of(context).lessThanFiveMinutesToComplete,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: RaisedButton(
                color: AppColors.orange,
                highlightElevation: 2,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          LanguageSelectionPage(widget.firstSurveyId)));
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(S.of(context).takeSurvey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
