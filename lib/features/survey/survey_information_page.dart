import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/features/survey/survey_loading_indicator.dart';
import 'package:libertaspeople/features/survey/survey_question_page.dart';
import 'package:libertaspeople/features/survey/widgets/next_previous_buttons.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/shared_ui_elements/shared_ui_elements.dart';

class SurveyInformationPage extends StatefulWidget {
  final String surveyId;

  const SurveyInformationPage(this.surveyId);

  @override
  _SurveyInformationPageState createState() => _SurveyInformationPageState();
}

class _SurveyInformationPageState extends State<SurveyInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).information)),
      body: BlocListener<SurveyCubit, SurveyState>(
        listener: (context, state) {
          if (state is FillingOutQuestionSurveyState) {
            Navigator.of(context).pushReplacement(
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              S.of(context).yourValuableInputIn5Minutes,
                              style: const TextStyle(
                                  fontSize: 23,
                                  color: AppColors.darkBlue,
                                  fontWeight: FontWeight.w500),
                              softWrap: true,
                            ),
                            const SizedBox(height: 40),
                            _buildRowItem(S
                                .of(context)
                                .pleaseAnswerFreelyBasedOnYourOwnExperiencesAndObservations),
                            const SizedBox(height: 25),
                            _buildRowItem(S
                                .of(context)
                                .nobodyShouldTellYouWhatToAnswerOrControlYouWhenYouTakeTheSurvey),
                            const SizedBox(height: 25),
                            _buildRowItem(S
                                .of(context)
                                .completingTheSurveyWillNotExposeYouToAnyRiskOrRepercussionWithYour),
                            const SizedBox(height: 25),
                            // _buildRowItem(S
                            //     .of(context)
                            //     .questionsMarkedWithAStarSymbolAreObligatoryToAnswer),
                            const SizedBox(height: 25),
                          ]),
                    ),
                  ),
                ),
                NextPreviousButtons(
                  onBackPressed: () => Navigator.pop(context),
                  onNextPressed: () =>
                      context.read<SurveyCubit>().startSurvey(widget.surveyId),
                  previousButtonLabel: S.of(context).back,
                )
              ],
            ),
            SurveyLoadingIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildRowItem(String text) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(width: 3, color: AppColors.darkBlue),
              ),
            ),
            const Icon(Icons.check, color: AppColors.orange),
          ],
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
