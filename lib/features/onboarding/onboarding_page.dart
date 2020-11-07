import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/constants/images.dart';
import 'package:libertaspeople/data_layer/repository.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/buttons/button_orange_color.dart';

import '../select_survey_frequency_page.dart';
import 'onboarding_tab_view.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  Repository repo = Repository();

  static const double LAST_TAB_INDEX = 2;
  int _currentPage = 0;
  PageController _controller = PageController();
  bool get _isLastPage => _currentPage == LAST_TAB_INDEX;

  void _onSwipe(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  _onLetsGetStartedButtonClick() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SelectSurveyFrequencyPage()));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabViewList = [
      OnBoardingTabView(
        topText:
            S.of(context).youAreInvitedToTakePartInTheStaffSurveyThatPlaysAn,
        bottomText: S
            .of(context)
            .youWillAnswer20MultipleChoiceQuestionsTheFirstTimeYouAccessTheSurvey,
        imagePath: AppImagePaths.onBoarding1,
      ),
      OnBoardingTabView(
        topText: S
            .of(context)
            .asPartOfMonitoringYouAreAskedToFillOutTheSurveyRegularly,
        bottomText: S
            .of(context)
            .afterTheInitialSurveyYouWillReceive10QuestionsEachMonth,
        imagePath: AppImagePaths.onBoarding2,
      ),
      OnBoardingTabView(
        topText: S.of(context).thisMonthsSurveyIsReadyForYou,
        bottomText:
            S.of(context).dontWorryWellNotifyYouWhenItsTimeToUpdateYourSurvey,
        imagePath: AppImagePaths.onBoarding3,
      ),
    ];

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    S.of(context).welcome,
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.orange),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: PageView(
                      onPageChanged: _onSwipe,
                      controller: _controller,
                      children: _tabViewList,
                    ),
                  ),
                  _buildLetsGetStartedButton(context),
                  _buildTabIndicatorRow(),
                  SizedBox(height: 10),
                  _buildSkipTextButton(_tabViewList, context),
                ]),
          ),
        ),
      ),
    );
  }

  SizedBox _buildSkipTextButton(
      List<Widget> _tabViewList, BuildContext context) {
    return SizedBox(
      height: 50,
      child: !_isLastPage
          ? Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () => _controller.animateToPage(_tabViewList.length,
                      curve: Curves.easeInOut, duration: Duration(seconds: 1)),
                  child: Text(
                    S.of(context).skip,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }

  Row _buildTabIndicatorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        3,
        (int index) {
          return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 15,
              width: 15,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (index == _currentPage)
                      ? AppColors.orange
                      : AppColors.greyAboutPage));
        },
      ),
    );
  }

  SizedBox _buildLetsGetStartedButton(BuildContext context) {
    return SizedBox(
      height: 100,
      child: _isLastPage
          ? Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              children: <Widget>[
                ButtonOrangeColor(
                  label: S.of(context).letsGetStarted,
                  onPressed: _onLetsGetStartedButtonClick,
                ),
              ],
            )
          : null,
    );
  }
}
