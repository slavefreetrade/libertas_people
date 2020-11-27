import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../shared_ui_elements/colors.dart';
import '../../shared_ui_elements/images.dart';
import 'about_data.dart';
import 'principle.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.darkBlue,
        title: Text(
          S.of(context).aboutSurvey,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 25, right: 25),
          child: Column(
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
              const SizedBox(height: 14),
              Row(
                children: [
                  Image.asset(
                    AppImages.logoImage,
                    height: 48.88,
                    width: 47,
                  ),
                  Flexible(
                    child: Text(
                      S.of(context).readMoreAboutSlavefreetrade,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
                        wordSpacing: 3.5,
                      ),
                      softWrap: true,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
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
                  padding: const EdgeInsets.all(10),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  crossAxisCount: 2,
                  childAspectRatio: 5 / 2,
                  children: getAboutData(context).map((principle) {
                    return FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Color(principle['color']),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: [
                            Text(
                              principle['id'],
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w300),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                              ),
                              child: Image.asset(
                                principle['image'],
                                width: principle['image_size'],
                              ),
                            ),
                            Flexible(
                              child: Text(
                                principle['title'].substring(
                                    0, principle['title'].length - 1),
                                style: TextStyle(
                                  fontSize: principle['size'],
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Principle(
                            logo: principle['logo'],
                            title: principle['title'],
                            text: principle['text'],
                          );
                        }));
                      },
                    );
                    //  return Container(
                    //   width: 150,
                    //   height: 55,
                    //   child: GestureDetector(
                    //      onTap: () {
                    //       Navigator.push(context, MaterialPageRoute(
                    //             builder: (BuildContext context) {
                    //           return Principle(
                    //             logo: principle['logo'],
                    //             title: principle['title'],
                    //             text: principle['text'],
                    //           );
                    //         }));
                    //       },
                    //      child: Image(
                    //        image: AssetImage(principle['image']),
                    //        fit: BoxFit.fill,
                    //       ),
                    //     ),
                    //  );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 54,
                width: 240,
                margin: const EdgeInsets.only(bottom: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40)),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    color: AppColors.orange,
                    onPressed: () {},
                    child: Text(
                      S.of(context).takeSurvey,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
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
