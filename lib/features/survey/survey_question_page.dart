import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/features/home/home_page.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:libertaspeople/features/survey/survey_loading_indicator.dart';
import 'package:libertaspeople/features/survey/survey_thankyou_page.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'multiple_choice_button_column.dart';

class SurveyQuestionPage extends StatefulWidget {
  static const routeName = '/survey-question-page';

  final int questionIndex;
  final int totalQuestionCount;
  final QuestionModel question;
  final Map answer;

  SurveyQuestionPage(this.questionIndex, this.totalQuestionCount, this.question,
      this.answer);

  @override
  _SurveyQuestionPageState createState() => _SurveyQuestionPageState();
}

class _SurveyQuestionPageState extends State<SurveyQuestionPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int get _questionIndex => widget.questionIndex;

  int get _totalCount => widget.totalQuestionCount;

  QuestionModel get _question => widget.question;

  final TextEditingController _textAnswerController = TextEditingController();

  bool get _isTextEntryQuestion => _question.choices == null;

  Map<String, dynamic> _answer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    print("_answer in survey quewiton page: ${_answer}");
    if (widget.answer != null) {
      _answer = widget.answer;
      if (_isTextEntryQuestion) {
        _textAnswerController.text = _answer[_question.questionId];
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.clear), onPressed: _onBackPressed),
        backgroundColor: ColorConstants.darkBlue,
        title: Text(
            "${widget.questionIndex}/${widget.totalQuestionCount} : ${_question
                .questionId}"),
        centerTitle: true,
      ),
      body: BlocListener<SurveyCubit, SurveyState>(
        listener: (context, state) {
          if (state is FillingOutQuestionSurveyState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    SurveyQuestionPage(
                        state.currentQuestionIndex,
                        state.totalQuestionCount,
                        state.question,
                        state.previousAnswer),
              ),
            );
          } else if (state is ThankYouSurveyState) {
            print("is navigating to thank you page");
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SurveyThankyouPage()));
          } else if (state is FailureSurveyState) {
            print("survey cubit failure" + state.message);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                // duration: Duration(milliseconds: 3000),
                content: Text(state.message),
              ),
            );

            // TODO display to user the error and probably exit survey?
          }
        },
        child: Stack(children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 12.0, left: 12, bottom: 16),
                    child: StepProgressIndicator(
                      totalSteps: _totalCount,
                      currentStep: _questionIndex,
                      size: 20,
                      selectedColor: ColorConstants.lightBlue,
                      unselectedColor: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 20),
                            // height: height * 0.35,
                            child: Text(
                              _question.display,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_isTextEntryQuestion)
                                _buildTextFieldAnswerWidget()
                              else
                              // _buildMCAnswerOptionsWidget(),
                                MultipleChoiceButtonColumn(
                                  _question.questionId,
                                  _question.choices,
                                  updateAnswer: (Map<String, dynamic> answer) {
                                    _answer = answer;
                                  },
                                  previousAnswer: _answer,
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  _nextAndPreviousButtons()
                ],
              ),
            ),
          ),
          SurveyLoadingIndicator()
        ]),
      ),
    );
  }

  _nextAndPreviousButtons() {
    bool isFinalQuestion = _questionIndex == _totalCount;

    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _questionIndex == 1
                ? Container()
                : FlatButton.icon(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.bloc<SurveyCubit>().previousQuestion();
              },
              padding: const EdgeInsets.all(10.0),
              textColor: ColorConstants.lightBlue,
              color: ColorConstants.white,
              label: const Text(
                "Previous",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: ColorConstants.lightBlue,
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: FlatButton.icon(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                // validate a button has been pressed or a text has been entered

                if (_answer == null) {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 1500),
                      content: Text("Please provide an answer. Thanks!"),
                    ),
                  );
                  print("must submit an answer");
                  print("show alert in app");
                  return;
                }

                if (isFinalQuestion) {
                  context.bloc<SurveyCubit>().completeSurvey(_answer);
                } else {
                  context.bloc<SurveyCubit>().nextQuestion(_answer);
                }
              },
              padding: const EdgeInsets.all(10.0),
              textColor: ColorConstants.white,
              color: ColorConstants.lightBlue,
              label: Text(
                isFinalQuestion ? "Complete" : "Next",
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: ColorConstants.lightBlue,
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  _buildTextFieldAnswerWidget() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
          controller: _textAnswerController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: (newValue) {
            _answer = {_question.questionId: newValue};
          }),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text(
              'Are you sure want to leave?',
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'It will only take a couple more minutes to finish.If you leave,your answers will be saved.',
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  "Continue",
                  style: const TextStyle(
                      color: ColorConstants.blueAboutPage, fontSize: 17),
                ),
              ),
              SizedBox(height: 16),
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: const Text(
                  "Leave",
                  style: const TextStyle(
                      color: ColorConstants.blueAboutPage, fontSize: 17),
                ),
              ),
            ],
          ),
    ) ??
        false;
  }
}
