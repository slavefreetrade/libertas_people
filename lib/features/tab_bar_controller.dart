import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/features/about/about.dart';
import 'package:libertaspeople/features/home/home_page_content/unfinished_survey_content.dart';
import 'package:libertaspeople/features/home/home_cubit.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'survey/survey_question_page.dart';
import 'home/home_page_content/home_page.dart';
import 'home/home_page_content/welcome_first_time_content.dart';
import 'home/home_page_content/no_survey_content.dart';
import 'home/home_page_content/welcome_back_content.dart';
import '../constants/colors.dart';

class TabBarController extends StatefulWidget {

  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {
  @override
  initState() {
    super.initState();

    context.bloc<HomeScreenCubit>().loadHomeScreen();
  }

  int pageIndex = 0;

  List<Widget> _pages = [HomePage(), AboutPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorConstants.darkBlue,
        backgroundColor: ColorConstants.greyAboutPage,
        onTap: (ind) {
          setState(() {
            pageIndex = ind;
          });
        },
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About Survey",
          ),
        ],
      ),
      body: _pages[pageIndex],
    );
  }
}
