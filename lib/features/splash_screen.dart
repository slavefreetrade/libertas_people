import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libertaspeople/data_layer/repository.dart';
import 'package:libertaspeople/features/onboarding/onboarding_page.dart';
import 'package:libertaspeople/features/tab_bar_controller.dart';
import 'package:libertaspeople/shared_ui_elements/images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Repository repo = Repository();

  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  _handleNavigation() async {
    final bool doesExist = await repo.userExists();
    if (!doesExist) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardingPage()));
      return;
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TabBarController()));
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
                child: Image.asset(AppImages.logoImage),
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
                child: Image.asset(AppImages.logoText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
