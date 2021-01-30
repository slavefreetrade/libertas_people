import 'package:flutter/material.dart';
import 'package:libertaspeople/shared_ui_elements/shared_ui_elements.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ThankYouPage extends StatefulWidget {
  static const routeName = '/thankyou';

  @override
  _ThankYouPageState createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  final _progressValue = 10.0;

  final _totalValue = 20.0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80)),
                child: Container(
                  height: height * 0.45,
                  color: AppColors.darkBlue,
                ),
              ),
              Positioned(
                top: height * 0.05,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 180.0,
                      animation: true,
                      animationDuration: 1500,
                      lineWidth: 22.0,
                      percent: _progressValue / _totalValue,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${_progressValue.toStringAsFixed(0)}/${_totalValue.toStringAsFixed(0)}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: AppColors.orange),
                          ),
                          const Text(
                            "surveys completed",
                            style: TextStyle(color: AppColors.white),
                          )
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: Colors.grey,
                      progressColor: AppColors.lightBlue,
                    ),
                    const Text(
                      "Thank you",
                      style: TextStyle(
                          color: AppColors.white,
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
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "We appreciate your engagement and time! Your answers will have a big impact in helping us determine the human rights conditions in your workplace.",
              style: TextStyle(fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Your next survey",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "XX.XX.XX",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.04),
            child: FlatButton(
              onPressed: () {},
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
              color: AppColors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: const Text(
                "Return Home",
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
