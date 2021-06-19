import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/privacyPolicyAndTerms/privacy_policy_page.dart';
import '../../features/privacyPolicyAndTerms/terms_and_conditions_page.dart';
import '../../generated/l10n.dart';
import '../../shared_ui_elements/colors.dart';
import 'about_data.dart';
import 'principle.dart';

class AboutPage extends StatefulWidget {
  final Function() onTakeSurveyPressed;

  const AboutPage({Key key, this.onTakeSurveyPressed}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          widget.onTakeSurveyPressed();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            brightness: Brightness.dark,
            backgroundColor: AppColors.darkBlue,
            title: Text(
              S.of(context).aboutSurvey,
            ),
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    S.of(context).privacyPolicy,
                    S.of(context).termsAndConditions,
                    S.of(context).slavefreetradeorg
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.only(top: 16.0, left: 25, right: 25),
            children: [
              Text(
                S
                    .of(context)
                    .theLibertasPeopleAppIsHowWeDeliverHumanRightsQuestionsToYouInASecure,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17.0,
                    wordSpacing: 3.5),
              ),
              const SizedBox(height: 11),
              Text(
                  S
                      .of(context)
                      .ourSurveyIsBasedOnThe10HumanRightPrinciplesOnInternationalLaw,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                      wordSpacing: 3.5)),
              const SizedBox(height: 11),
              Text(S.of(context).tapOnEachButtonToReadMoreAboutEachPrinciple,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                      wordSpacing: 3.5)),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(6),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  children: getAboutData(context).map((principle) {
                    return TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Color(principle['color'] as int),
                        ),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Principle(
                            logo: principle['logo'] as String,
                            title: principle['title'] as String,
                            text: principle['text'] as String,
                          );
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          children: [
                            Center(
                              child: Image.asset(
                                principle['image'] as String,
                                width: principle['image_size'] as double,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                principle['title'] as String,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ));
  }

  void handleClick(String value) {
    if (value == S.of(context).privacyPolicy) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()));
    } else if (value == S.of(context).termsAndConditions) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const TermsAndConditionsPage()));
    } else if (value == S.of(context).slavefreetradeorg) {
      launchSlavefreetradeWebsite();
    }
  }

  Future<void> launchSlavefreetradeWebsite() async {
    const url = 'https://www.slavefreetrade.org';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
