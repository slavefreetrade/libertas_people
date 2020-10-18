import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.darkBlue,
        title: Center(
          child: Text(
            'About',
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: ColorConstants.darkBlue),
        BottomNavigationBarItem(
            icon: Icon(Icons.report),
            title: Text('About Survey'),
            backgroundColor: ColorConstants.darkBlue),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            backgroundColor: ColorConstants.darkBlue),
      ]),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'The Libertas People app is how we deliver human rights questions to you in a secure, anonymous, and confidential way. ',
                style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w400,
                    fontSize: 17.0,
                    wordSpacing: 3.5),
              ),
              SizedBox(height: 11),
              Text(
                  'Our survey is based on the 10 human right principles on international law. ',
                  style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                      wordSpacing: 3.5)),
              SizedBox(height: 14),
              Row(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 48.88,
                    width: 47,
                  ),
                  Text(
                    'Read more about slavefreetrade',
                    style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
                        wordSpacing: 3.5),
                  )
                ],
              ),
              SizedBox(height: 10),
              Text('Tap on each button to read more about each principle:',
                  style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                      wordSpacing: 3.5)),
              SizedBox(height: 14),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset(
                  'assets/principle-01.png',
                  height: 54.0,
                  width: 145,
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  'assets/principle-02.png',
                  height: 54.0,
                  width: 145,
                  fit: BoxFit.fill,
                )
              ]),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset(
                  'assets/principle-03.png',
                  height: 54.0,
                  width: 145,
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  'assets/principle-04.png',
                  height: 54.0,
                  width: 145,
                  fit: BoxFit.fill,
                )
              ]),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset(
                  'assets/principle-05.png',
                  height: 54.0,
                  width: 145,
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  'assets/principle-06.png',
                  height: 54.0,
                  width: 145,
                  fit: BoxFit.fill,
                )
              ]),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset(
                  'assets/principle-07.png',
                  height: 54.0,
                  width: 145,
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  'assets/principle-08.png',
                  height: 54.0,
                  width: 145,
                  fit: BoxFit.fill,
                )
              ]),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset(
                  'assets/principle-09.png',
                  height: 54.0,
                  width: 145,
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  'assets/principle-10.png',
                  height: 54.0,
                  width: 145,
                  fit: BoxFit.fill,
                )
              ]),
              SizedBox(height: 33),
              Container(
                height: 54,
                width: 240,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40)),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    color: ColorConstants.orange,
                    onPressed: () {},
                    child: Text(
                      'Take survey',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
