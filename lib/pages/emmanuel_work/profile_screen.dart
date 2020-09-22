import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/pages/emmanuel_work/widgets/about_survey.dart';
import 'package:libertaspeople/pages/emmanuel_work/widgets/custom_form.dart';
import 'package:libertaspeople/pages/emmanuel_work/widgets/home_page.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Profile Screen",
      theme: ThemeData(
        primaryColor: ColorConstants.darkBlue,
        scaffoldBackgroundColor: ColorConstants.white
      ),
      home: ProfileScreenTab()
    );
  }
}

// Profile Screen Tab

class ProfileScreenTab extends StatefulWidget {
  @override
  _ProfileScreenTabState createState() => _ProfileScreenTabState();
}

class _ProfileScreenTabState extends State<ProfileScreenTab> {


  final String title = "Profile";
  int _selectedIndex = 0;

  PageController _pageController = PageController();
  List<Widget> _screen = [
    HomePage(),
    AboutSurvey(),
    CustomForm()
  ];

  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
          title: Text(title, style: TextStyle(fontSize: 25.0),),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: PageView(
          controller: _pageController,
          children: _screen,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? ColorConstants.darkBlue : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.info_outline,
              color: _selectedIndex == 1 ? ColorConstants.darkBlue : Colors.grey,
            ),
            label: 'About survey',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.person,
              color: _selectedIndex == 2 ? ColorConstants.darkBlue : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConstants.darkBlue,
        onTap: _onItemTapped,
        iconSize: 40.2,

      ),
    );
  }
}

