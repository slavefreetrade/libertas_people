import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data_layer/repository.dart';
import '../../features/privacyPolicyAndTerms/privacy_policy_page.dart';
import '../../generated/l10n.dart';
import '../../services/notification_service.dart';
import '../../shared_ui_elements/buttons/button_orange_color.dart';
import '../../shared_ui_elements/colors.dart';
import '../../shared_ui_elements/images.dart';
import 'onboarding_tab_view.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  Repository repo = Repository();

  static const double lastTabIndex = 2;
  int _currentPage = 0;
  final PageController _controller = PageController();
  bool get _isLastPage => _currentPage == lastTabIndex;

  void _onSwipe(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onLetsGetStartedButtonClick() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const PrivacyPolicyPage(
              shouldShowAccept: true,
            )));
  }

  @override
  void initState() {
    NotificationService().subscribeToOnBoardingNotCompletedNotification();
    super.initState();
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
        imagePath: AppImages.onBoarding1,
      ),
      OnBoardingTabView(
        topText: S
            .of(context)
            .asPartOfMonitoringYouAreAskedToFillOutTheSurveyRegularly,
        bottomText: S
            .of(context)
            .afterTheInitialSurveyYouWillReceive10QuestionsEachMonth,
        imagePath: AppImages.onBoarding2,
      ),
      OnBoardingTabView(
        topText: S.of(context).thisMonthsSurveyIsReadyForYou,
        bottomText:
            S.of(context).dontWorryWellNotifyYouWhenItsTimeToUpdateYourSurvey,
        imagePath: AppImages.onBoarding3,
      ),
    ];

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(children: [
              const SizedBox(height: 10),
              Text(
                S.of(context).welcome,
                style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: PageView(
                  onPageChanged: _onSwipe,
                  controller: _controller,
                  children: _tabViewList,
                ),
              ),
              _buildLetsGetStartedButton(context),
              _buildTabIndicatorRow(),
              const SizedBox(height: 10),
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
              children: <Widget>[
                InkWell(
                  onTap: () => _controller.animateToPage(_tabViewList.length,
                      curve: Curves.easeInOut,
                      duration: const Duration(seconds: 1)),
                  child: Text(
                    S.of(context).skip,
                    style: const TextStyle(
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
              duration: const Duration(milliseconds: 300),
              height: 15,
              width: 15,
              margin: const EdgeInsets.symmetric(horizontal: 10),
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
