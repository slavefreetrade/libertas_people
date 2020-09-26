import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

import 'base/base_view.dart';
import 'models/profile_query_model.dart';
import 'profile_creation_view_model.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final List<ProfileFormQuestionModel> _questions = [
      ProfileFormQuestionModel(
          question: S.of(context).pleaseEnterTheWorkplaceIdThat,
          options: [S.of(context).workplaceId]),
      ProfileFormQuestionModel(
          question: S.of(context).whatIsYourGender,
          options: [
            S.of(context).male,
            S.of(context).female,
            S.of(context).other,
            S.of(context).preferNotToSay,
          ]),
      ProfileFormQuestionModel(
        question: S.of(context).yourWorkplaceIs,
        options: [
          S.of(context).anOfficeOrAFactory,
          S.of(context).aFieldOrAFarm,
          S.of(context).other
        ],
      ),
      ProfileFormQuestionModel(
          question: S.of(context).whichAgeGroupAreYouIn,
          options: [
            S.of(context).lessThan15Years,
            S.of(context).from15To18Years,
            S.of(context).from19To25Years,
            S.of(context).from26To39Years,
            S.of(context).from40To59Years,
            S.of(context).moreThan60Years
          ]),
      ProfileFormQuestionModel(
          question: S.of(context).areYouAManagerInYourDepartment,
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
                  appBar: AppBar(
                    title: Text('${_progressIndex + 1} / ${_questions.length}'),
                    titleSpacing: 0.0,
                    centerTitle: true,
                    actions: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            S.of(context).close,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                        ),
                      )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 15),
                        HeaderProgressBar(
                          animatedDuration: const Duration(seconds: 1),
                          currentIndex: _progressIndex,
                          maxIndex: _questions.length - 1,
                        ),
                        const SizedBox(height: 15),
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
                            const SizedBox(height: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Future<bool> _onWillPop() async {
    final bool isInitialPage = _pageController.hasClients
        ? _pageController.page == 0
        : _pageController.initialPage == 0;

    if (isInitialPage) {
      return true;
    } else {
      _onPressedBack();
      return false;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPressedNext() {
    print('going from ${_pageController.page} to ${_pageController.page + 1}');
    _progressIndex++;
    _pageController.jumpToPage(_progressIndex);
    setState(() {});
  }

  void _onPressedBack() {
    print('going from ${_pageController.page} to ${_pageController.page - 1}');
    _progressIndex--;
    _pageController.jumpToPage(_progressIndex);
    setState(() {});
  }
}
