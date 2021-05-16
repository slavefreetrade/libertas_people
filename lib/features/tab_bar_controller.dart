import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/features/about/about.dart';
import 'package:libertaspeople/features/home/home_cubit.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/images.dart';

import '../shared_ui_elements/colors.dart';
import 'home/home_page_content/home_page.dart';

class TabBarController extends StatefulWidget {
  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenCubit>().loadHomeScreen();
  }

  int pageIndex = 0;

  void _animateToPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.darkBlue,
        backgroundColor: AppColors.greyAboutPage,
        onTap: _animateToPage,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.logoImage,
              height: 26,
              width: 26,
              color: pageIndex == 0
                  ? Colors.black54
                  : AppColors.darkBlue,
            ),
            label: S.of(context).aboutSurvey,
          ),
        ],
      ),
      body: _getPage(),
    );
  }

  Widget _getPage() {
    switch (pageIndex) {
      case 0:
        return const HomePage();
      default:
        return AboutPage(onTakeSurveyPressed: () => _animateToPage(0));
    }
  }
}
