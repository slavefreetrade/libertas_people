import 'package:flutter/material.dart';
import 'package:libertaspeople/generated/l10n.dart';

import 'base/base_view.dart';
import 'models/profile_query_model.dart';
import 'profile_creation_view_model.dart';
import 'shared/utils/extensions.dart';
import 'widgets/bottom_action_buttons.dart';
import 'widgets/header_progress_bar.dart';
import 'widgets/multiselect_form_view.dart';

class ProfileCreationView extends StatefulWidget {
  const ProfileCreationView({Key key}) : super(key: key);

  @override
  _ProfileCreationViewState createState() => _ProfileCreationViewState();
}

class _ProfileCreationViewState extends State<ProfileCreationView> {
  int _progressIndex = 0;
  PageController _pageController;
  Duration animationDuration = const Duration(microseconds: 50);
  Curve animationCurve = Curves.easeIn;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final List<ProfileFormQuestionModel> _questions = [
      ProfileFormQuestionModel(
          title: S.of(context).workplaceId,
          question: S.of(context).pleaseEnterTheWorkplaceIdThat,
          progressLabel: S.of(context).id,
          options: [S.of(context).workplaceId]),
      ProfileFormQuestionModel(
          title: S.of(context).gender,
          question: S.of(context).whatIsYourGender,
          progressLabel: S.of(context).gender,
          options: [
            S.of(context).male,
            S.of(context).female,
            S.of(context).other,
            S.of(context).preferNotToSay,
          ]),
      ProfileFormQuestionModel(
        title: S.of(context).workplace,
        question: S.of(context).yourWorkplaceIs,
        progressLabel: S.of(context).workplace,
        options: [
          S.of(context).anOfficeOrAFactory,
          S.of(context).aFieldOrAFarm,
          S.of(context).other
        ],
      ),
      ProfileFormQuestionModel(
          title: S.of(context).age,
          question: S.of(context).whichAgeGroupAreYouIn,
          progressLabel: S.of(context).age,
          options: [
            S.of(context).lessThan15Years,
            S.of(context).from15To18Years,
            S.of(context).from19To25Years,
            S.of(context).from26To39Years,
            S.of(context).from40To59Years,
            S.of(context).moreThan60Years
          ]),
      ProfileFormQuestionModel(
          title: S.of(context).role,
          question: S.of(context).areYouAManagerInYourDepartment,
          progressLabel: S.of(context).role,
          options: [S.of(context).yes, S.of(context).no]),
    ];

    return BaseView<ProfileCreationViewModel>(
        model: ProfileCreationViewModel(),
        builder: (BuildContext context, ProfileCreationViewModel model,
                Widget child) =>
            WillPopScope(
              onWillPop: _onWillPop,
              child: SafeArea(
                child: Scaffold(
                  appBar:
                      _buildAppBar(context, _questions[_progressIndex].title),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HeaderProgressBar(
                          animatedDuration: const Duration(seconds: 1),
                          currentIndex: _progressIndex,
                          maxIndex: _questions.length - 1,
                        ),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: _questions
                                .map(
                                    (question) => MultiSelectFormPage(question))
                                .toList(),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BottomActionButtons(
                              onPressedBack: _onPressedBack,
                              onPressedNext: _onPressedNext,
                              // ignore: avoid_bool_literals_in_conditional_expressions
                              showBack: _pageController.hasClients
                                  ? _pageController.page != 0
                                  : false,
                              // ignore: avoid_bool_literals_in_conditional_expressions
                              showNext: _pageController.hasClients
                                  ? _pageController.page !=
                                      _questions.length - 1
                                  : true,
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  AppBar _buildAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      toolbarHeight: context.height * 0.15,
    );
  }

  Future<bool> _onWillPop() async {
    final bool isInitialPage = _pageController.hasClients
        ? _pageController.page == 0
        : _pageController.initialPage == 0;

    if (isInitialPage) {
      return true;
    } else {
      await _onPressedBack();
      return false;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onPressedNext() async {
    print('going from ${_pageController.page} to ${_pageController.page + 1}');

    _progressIndex++;
    await _pageController.animateToPage(_progressIndex,
        duration: animationDuration, curve: animationCurve);
    setState(() {});
  }

  Future<void> _onPressedBack() async {
    print('going from ${_pageController.page} to ${_pageController.page - 1}');

    _progressIndex--;
    await _pageController.animateToPage(_progressIndex,
        duration: animationDuration, curve: animationCurve);

    setState(() {});
  }
}
