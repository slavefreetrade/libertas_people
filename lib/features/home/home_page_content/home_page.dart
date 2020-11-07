import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/features/home/home_page_content/unfinished_survey_content.dart';
import 'package:libertaspeople/features/home/home_page_content/welcome_back_content.dart';
import 'package:libertaspeople/features/home/home_page_content/welcome_first_time_content.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:libertaspeople/features/survey/survey_question_page.dart';

import '../home_cubit.dart';
import 'no_survey_content.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SurveyCubit, SurveyState>(
        listener: (context, state) {
          if (state is FillingOutQuestionSurveyState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SurveyQuestionPage(
                    state.currentQuestionIndex,
                    state.totalQuestionCount,
                    state.question,
                    state.previousAnswer),
              ),
            );
          }
        },
        child: Column(
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
                    color: AppColors.darkBlue,
                    child: Center(
                      child: Text(
                        "Libertas People",
                        style: TextStyle(
                          color: AppColors.white,
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
                            } else if (state
                                is UnfinishedSurveyHomeScreenState) {
                              print('state.surveyID: ${state.surveyId}');
                              print("state.sessionId: ${state.sessionId}");
                              return UnfinishedSurveyContent(
                                  surveyId: state.surveyId,
                                  sessionId: state.sessionId);
                            } else if (state
                                is WelcomeFirstTimeHomeScreenState) {
                              return WelcomeFirstTimeContent(
                                  state.firstSurveyId);
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
        ));
  }
}
