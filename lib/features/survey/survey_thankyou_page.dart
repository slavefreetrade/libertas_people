import 'package:flutter/material.dart';
import 'package:libertaspeople/features/tab_bar_controller.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/shared_ui_elements.dart';

class SurveyThankYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              S
                  .of(context)
                  .youHaveCompletedTheFirstSurveyAndYourAnswerHaveBeenSubmitted,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 25),
          Center(
            child: Text(
              S.of(context).whatHappensNext,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ButtonOrangeColor(
              label: S.of(context).returnHome,
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => TabBarController()));
              },
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
