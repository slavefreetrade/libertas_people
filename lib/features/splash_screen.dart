import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libertaspeople/data_layer/repository.dart';
import 'package:libertaspeople/features/tab_bar_controller.dart';
import 'package:libertaspeople/features/select_survey_frequency_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String PlaceHolderLogoImage = 'assets/slavefreetrade_logo.png';

  final String placeholdLogoText = "assets/slavefreetrade_logo_text.png";

  Repository repo = Repository();

  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  _handleNavigation() async {
    final bool doesExist = await repo.userExists();
    if (!doesExist) {

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SelectSurveyFrequencyPage()));
      return;
    }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => TabBarController()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 175.0,
                width: 175.0,
                child: Image.asset(PlaceHolderLogoImage),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50.0,
                width: 250.0,
                child: Image.asset(placeholdLogoText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
