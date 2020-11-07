import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libertaspeople/features/survey/lauguage_selection_page.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/colors.dart';
import 'package:libertaspeople/shared_ui_elements/images.dart';

class WelcomeFirstTimeContent extends StatefulWidget {
  final String firstSurveyId;

  const WelcomeFirstTimeContent(this.firstSurveyId);

  @override
  _WelcomeFirstTimeContentState createState() =>
      _WelcomeFirstTimeContentState();
}

class _WelcomeFirstTimeContentState extends State<WelcomeFirstTimeContent> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).welcomeOnboard,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              S
                  .of(context)
                  .weAreHappyThatYouWantToTakePartInOurSurveyThatPlaysAnImportantPartIn,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
            ),
            SizedBox(
              height: 13,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 11.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          child: Image.asset(AppImages.ima),
                        ),
                        Text(
                          S.of(context).alwaysAnonymous,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 70,
                        child: Image.asset(AppImages.i),
                      ),
                      Text(
                        S.of(context).onlyBinaryQuestions,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 70,
                        child: Image.asset(AppImages.im),
                      ),
                      Flexible(
                        child: Text(
                          S.of(context).lessThanFiveMinutesToComplete,
                          style: TextStyle(
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(S.of(context).takeSurvey),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
