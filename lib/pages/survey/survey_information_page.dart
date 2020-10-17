import 'package:flutter/material.dart';
import 'package:libertaspeople/pages/survey/survey_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/pages/survey/survey_loading_indicator.dart';
import 'package:libertaspeople/pages/survey/survey_question_page.dart';

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
      appBar: AppBar(title: Text("Survey Info")),
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
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Survey Information Page"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Back"),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Start"),
                      ),
                      onPressed: () {
                        context
                            .bloc<SurveyCubit>()
                            .startSurvey(widget.surveyId);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          SurveyLoadingIndicator()
        ]),
      ),
    );
  }
}
