import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/features/about/about.dart';
import 'package:libertaspeople/features/home/home_cubit.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'home/home_page_content/home_page.dart';
import '../shared_ui_elements/colors.dart';

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
        selectedItemColor: AppColors.darkBlue,
        backgroundColor: AppColors.greyAboutPage,
        onTap: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: S.of(context).aboutSurvey,
          ),
        ],
      ),
      body: _pages[pageIndex],
    );
  }
}
