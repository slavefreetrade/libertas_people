import 'package:flutter/material.dart';

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

  final List<Widget> _pages = [
    MultiSelectFormPage(ProfileFormQuestionModel(
        title: 'test1', options: ['olo', 'lol'], selectedIndex: 1)),
    MultiSelectFormPage(
        ProfileFormQuestionModel(title: 'test2', options: ['sho', 'pooo'])),
    MultiSelectFormPage(
        ProfileFormQuestionModel(title: 'test3', options: ['olo', 'lol'])),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileCreationViewModel>(
        model: ProfileCreationViewModel(),
        builder: (BuildContext context, ProfileCreationViewModel model,
                Widget child) =>
            WillPopScope(
              onWillPop: _onWillPop,
              child: SafeArea(
                child: Scaffold(
                  appBar: _buildAppBar(context),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HeaderProgressBar(
                          animatedDuration: const Duration(seconds: 1),
                          currentValue: _progressIndex,
                          maxValue: _pages.length - 1,
                        ),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: _pages,
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
                                  ? _pageController.page != _pages.length - 1
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Workplace ID'),
      centerTitle: true,
      toolbarHeight: context.height * 0.15,
    );
  }

  Future<bool> _onWillPop() async {
    if (_pageController.hasClients
        ? _pageController.page == 0
        : _pageController.initialPage == 0) {
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
