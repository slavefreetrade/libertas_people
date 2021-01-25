import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/features/tab_bar_controller.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:libertaspeople/features/survey/survey_loading_indicator.dart';
import 'package:libertaspeople/features/survey/survey_thankyou_page.dart';
import 'package:libertaspeople/features/survey/widgets/next_previous_buttons.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/shared_ui_elements/colors.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'multiple_choice_button_column.dart';

class SurveyQuestionPage extends StatefulWidget {
  static const routeName = '/survey-question-page';

  final int questionIndex;
  final int totalQuestionCount;
  final QuestionModel question;
  final Map answer;

  SurveyQuestionPage(
      this.questionIndex, this.totalQuestionCount, this.question, this.answer);

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
    super.initState();

    print("_answer in survey quesiton page: ${_answer}");
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
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => _onBackPressed(context)),
          backgroundColor: AppColors.darkBlue,
        ),
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
            } else if (state is ThankYouSurveyState) {
              print("is navigating to thank you page");
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SurveyThankYouPage()));
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
            Padding(
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
                      selectedColor: AppColors.lightBlue,
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
                  NextPreviousButtons(
                    isFinalQuestion: _questionIndex == _totalCount,
                    isFirstQuestion: _questionIndex == 1,
                    onBackPressed: () {
                      context.bloc<SurveyCubit>().previousQuestion();
                    },
                    onNextPressed: () {
                      // validate a button has been pressed or a text has been entered

                      if (_answer == null) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 1500),
                            content:
                                Text(S.of(context).pleaseProvideAnAnswerThanks),
                          ),
                        );
                        print("must submit an answer");
                        print("show alert in app");
                        return;
                      }

                      final isFinalQuestion = _questionIndex == _totalCount;

                      if (isFinalQuestion) {
                        context.bloc<SurveyCubit>().completeSurvey(_answer);
                      } else {
                        context.bloc<SurveyCubit>().nextQuestion(_answer);
                      }
                    },
                  ),
                ],
              ),
            ),
            SurveyLoadingIndicator()
          ]),
        ),
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

  Future<bool> _onBackPressed(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              S.of(context).areYouSureWantToLeave,
              textAlign: TextAlign.center,
            ),
            content: Text(
              S
                  .of(context)
                  .itWillOnlyTakeACoupleMoreMinutesToFinishIfYouLeaveYourAnswersWillBeSaved,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  S.of(context).continueText,
                  style: const TextStyle(
                      color: AppColors.blueAboutPage, fontSize: 17),
                ),
              ),
              SizedBox(height: 16),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => TabBarController()),
                      (route) => route.isFirst);
                },
                child: Text(
                  S.of(context).leave,
                  style: const TextStyle(
                      color: AppColors.blueAboutPage, fontSize: 17),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
