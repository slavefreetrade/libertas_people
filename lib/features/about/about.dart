import 'package:flutter/material.dart';
import 'package:libertaspeople/features/about/about_data.dart';
import 'package:libertaspeople/features/about/principle.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/colors.dart';
import 'package:libertaspeople/shared_ui_elements/images.dart';

class AboutPage extends StatefulWidget {
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
                  Text(
                    S.of(context).readMoreAboutSlavefreetrade,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
                        wordSpacing: 3.5),
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
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(10),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  crossAxisCount: 2,
                  childAspectRatio: 6 / 2,
                  children: getAboutData(context).map((prin) {
                    return Container(
                      width: 150,
                      height: 55,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Principle(
                              logo: prin['logo'],
                              title: prin['title'],
                              text: prin['text'],
                            );
                          }));
                        },
                        child: Image(
                          image: AssetImage(prin['image']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
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
                      style: TextStyle(
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
