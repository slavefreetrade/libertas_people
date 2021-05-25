import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../../shared_ui_elements/colors.dart';
import '../../../shared_ui_elements/images.dart';
import '../../survey/survey_cubit.dart';
import '../../survey/survey_question_page.dart';
import '../home_cubit.dart';
import 'no_survey_content.dart';
import 'unfinished_survey_content.dart';
import 'welcome_back_content.dart';
import 'welcome_first_time_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      AssetImage(AppImages.womenFallingInLineHoldingEachOther),
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
                        S.of(context).libertasPeople,
                        style: const TextStyle(
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
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 35),
                children: <Widget>[
                  BlocBuilder<HomeScreenCubit, HomeScreenState>(
                    builder: (context, state) {
                      if (state is LoadingHomeScreenState ||
                          state is UninitializedHomeScreenState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UnfinishedSurveyHomeScreenState) {
                        return UnfinishedSurveyContent(
                            surveyId: state.surveyId,
                            sessionId: state.sessionId);
                      } else if (state is WelcomeFirstTimeHomeScreenState) {
                        return WelcomeFirstTimeContent(
                            firstSurveyId: state.firstSurveyId);
                      } else if (state is WelcomeBackHomeScreenState) {
                        return WelcomeBackContent(state.surveyId);
                      } else if (state is NoSurveyHomeScreenState) {
                        return const NoSurveyContent();
                      } else if (state is FailureHomeScreenState) {
                        return Center(
                            child: Text(
                                S.of(context).thereWasAnIssue(state.message)));
                      }
                      return Center(
                        child: Text(S
                            .of(context)
                            .thereIsAnUnexpectedStateInTheBlocBuilderThisShouldBeHandledByDevelopment),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
