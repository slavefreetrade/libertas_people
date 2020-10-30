import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  PageController _controller = PageController();

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 23),
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.orange),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: Text(
                      'You are invited to take part in the staff '
                      'survey that plays an important part in '
                      'monitoring human rights conditions at '
                      'work places.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xff103F75),
                          fontFamily: 'Helvetica Neue',
                          fontWeight: FontWeight.w400,
                          fontSize: 17.0,
                          wordSpacing: 3.5),
                    ),
                  ),
                  Container(
                    height: 358.46,
                    width: 313.48,
                    child: PageView(
                      onPageChanged: _onchanged,
                      controller: _controller,
                      children: [
                        Image.asset('assets/onboarding-1.png'),
                        Image.asset('assets/onboarding-2.png'),
                        Image.asset('assets/onboarding-3.png')
                      ],
                    ),
                  ),
                  Text(
                    'You will answer 20 multiple '
                    'choice questions the first time '
                    'you access the survey.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff103F75),
                        fontFamily: 'Helvetica Neue',
                        fontSize: 22.0,
                        fontWeight: FontWeight.w400,
                        wordSpacing: 3.5),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(3, (int index) {
                        return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: 15,
                            width: 15,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: (index == _currentPage)
                                    ? ColorConstants.orange
                                    : ColorConstants.greyAboutPage));
                      })),
                  MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 14,
                            color: ColorConstants.darkBlue,
                            decoration: TextDecoration.underline),
                      )),
                ]),
          ),
        ),
      ),
    );
  }
}
