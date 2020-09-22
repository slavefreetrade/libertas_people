import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/pages/emmanuel_work/widgets/custom_form.dart';

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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final String title = "Profile";


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(title, style: TextStyle(fontSize: 25.0),),
          centerTitle: true,
          elevation: 0.0,
        ),
        body:Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About survey',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: ColorConstants.orange
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConstants.darkBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}

