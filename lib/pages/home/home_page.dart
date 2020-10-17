import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/pages/home/home_page_content/unfinished_survey_content.dart';
import 'package:libertaspeople/pages/home/home_cubit.dart';
import 'package:libertaspeople/pages/splash_screen.dart';
import 'package:libertaspeople/pages/survey/survey_cubit.dart';
import '../survey/survey_question_page.dart';
import 'home_page_content/welcome_first_time_content.dart';
import 'home_page_content/no_survey_content.dart';
import 'home_page_content/welcome_back_content.dart';
import '../../constants/colors.dart';

class HomePage extends StatefulWidget {
  final num;

  HomePage({this.num});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();

    context.bloc<HomeScreenCubit>().loadHomeScreen();
  }

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorConstants.darkBlue,
        backgroundColor: ColorConstants.greyAboutPage,
        onTap: (ind) {
          setState(() {
            pageIndex = ind;
          });
        },
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About Survey",
          ),
        ],
      ),
      // body: tabPages[pageIndex],

      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    "assets/woman-falling-in-line-holding-each-other-1206059 1.jpg"),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 50,
                  color: ColorConstants.darkBlue,
                  child: Center(
                    child: Text(
                      "Libertas People",
                      style: TextStyle(
                        color: ColorConstants.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                        builder: (context, state) {
                          if (state is LoadingHomeScreenState ||
                              state is UninitializedHomeScreenState) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is UnfinishedSurveyHomeScreenState) {
                            return UnfinishedSurveyContent(
                                surveyId: state.surveyId,
                                sessionId: state.sessionId);
                          } else if (state is WelcomeFirstTimeHomeScreenState) {
                            return WelcomeFirstTimeContent(state.firstSurveyId);
                          } else if (state is WelcomeBackHomeScreenState) {
                            return WelcomeBackContent(state.surveyId);
                          } else if (state is NoSurveyHomeScreenState) {
                            return NoSurveyContent();
                          } else if (state is FailureHomeScreenState) {
                            return Center(
                                child: Text(
                                    "There was an issue: ${state.message}"));
                          }
                          return Center(
                            child: Text(
                                "There is an unexpected state in the bloc builder, this should be handled by development"),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
