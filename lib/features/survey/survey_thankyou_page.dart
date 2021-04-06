import 'package:flutter/material.dart';
import 'package:libertaspeople/features/tab_bar_controller.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/shared_ui_elements.dart';

class SurveyThankYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80)),
                child: Container(
                  height: height * 0.35,
                  color: AppColors.darkBlue,
                ),
              ),
              Positioned(
                top: height * 0.05,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(AppImages.thankYou),
                      height: 130,
                      width: 130,
                    ),
                    Text(
                      S.of(context).thankYou,
                      style: const TextStyle(
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              S
                  .of(context)
                  .youHaveCompletedTheFirstSurveyAndYourAnswerHaveBeenSubmitted,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              S.of(context).whatHappensNext,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(6.0),
              children: <Widget>[
                ListTile(
                  leading: const SizedBox(
                      width: 50,
                      height: 50,
                      child: Image(image: AssetImage(AppImages.calendar))),
                  title: Text(S
                      .of(context)
                      .forTheNext10MonthsYouWillReceive10QuestionsPerMonthHereInTheApp),
                ),
                ListTile(
                  leading: const SizedBox(
                      width: 50,
                      height: 50,
                      child: Image(image: AssetImage(AppImages.bell))),
                  title: Text(S
                      .of(context)
                      .youWillGetAMonthlyNotificationOnYourPhoneOnceTheQuestionsAreReadyYouCan),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60, top: 10),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                ),
                backgroundColor: MaterialStateProperty.all(AppColors.orange),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => TabBarController()));
              },
              child: Text(
                S.of(context).returnHome,
                style: const TextStyle(
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
