import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ThankyouPage extends StatefulWidget {
  static const routeName = '/thankyou';

  @override
  _ThankyouPageState createState() => _ThankyouPageState();
}

class _ThankyouPageState extends State<ThankyouPage> {
  final _progressValue = 10.0;

  final _totalValue = 20.0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      width: width,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80)),
                child: Container(
                  height: height * 0.45,
                  color: ColorConstants.darkBlue,
                ),
              ),
              Positioned(
                top: height * 0.05,
                left: width / 3.7,
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 180.0,
                      animation: true,
                      animationDuration: 1500,
                      lineWidth: 22.0,
                      percent: (_progressValue / _totalValue),
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _progressValue.toStringAsFixed(0) +
                                "/" +
                                _totalValue.toStringAsFixed(0),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: ColorConstants.orange),
                          ),
                          const Text(
                            "surveys completed",
                            style: const TextStyle(color: ColorConstants.white),
                          )
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: Colors.grey,
                      progressColor: ColorConstants.lightBlue,
                    ),
                    const Text(
                      "Thank you",
                      style: const TextStyle(
                          color: ColorConstants.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              "We appreciate your engagement and time! Your answers will have a big impact in helping us determine the human rights conditions in your workplace.",
              style: const TextStyle(fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Your next survey",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "XX.XX.XX",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.04),
            child: FlatButton(
              onPressed: () {
                print("clicked return button");
              },
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
              color: ColorConstants.orange,
              child: const Text(
                "Return Home",
                style: const TextStyle(
                    fontSize: 20,
                    color: ColorConstants.white,
                    fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    ));
  }
}
