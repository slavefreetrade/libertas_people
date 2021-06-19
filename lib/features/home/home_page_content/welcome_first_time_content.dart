import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../generated/l10n.dart';
import '../../../shared_ui_elements/buttons/button_orange_color.dart';
import '../../../shared_ui_elements/images.dart';

import '../../survey/survey_information_page.dart';

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
    return Column(
      children: [
        Text(
          S
              .of(context)
              .weAreHappyThatYouWantToTakePartInOurSurveyThatPlaysAnImportantPartIn,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          softWrap: true,
        ),
        const SizedBox(height: 25),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.ima,
                  height: 50,
                  width: 50,
                ),
                const Spacer(),
                Flexible(
                  flex: 20,
                  child: Text(
                    S.of(context).alwaysAnonymous,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child:
                SvgPicture.asset(
                  AppImages.yesNo1Svg,
                  height: 50,
                  width: 50,
                ),
                // ),
                const Spacer(),
                Flexible(
                  flex: 20,
                  child: Text(
                    S.of(context).onlyBinaryQuestions,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.im,
                  height: 50,
                  width: 50,
                ),
                const Spacer(),
                Flexible(
                  flex: 20,
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
        const SizedBox(height: 30),

        //TODO: make the action button closer to the bottom
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ButtonOrangeColor(
                  label: S.of(context).takeSurvey,
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            SurveyInformationPage(widget.firstSurveyId),
                      ),
                    );
                    setState(() {
                      _isLoading = false;
                    });
                  }),
            ),
          ),
      ],
    );
  }
}
