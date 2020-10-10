import 'package:flutter/material.dart';
import 'package:libertaspeople/pages/survey/survey_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/pages/survey_question_page.dart';

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
                builder: (context) => SurveyQuestionPage(),
              ),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("survey info"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    child: Text("back"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    child: Text("Start Survey"),
                    onPressed: () {
                      context.bloc<SurveyCubit>().startSurvey(widget.surveyId);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
