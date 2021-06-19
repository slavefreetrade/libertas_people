import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/features/tab_bar_controller.dart';
import 'package:libertaspeople/features/survey/survey_cubit.dart';
import 'package:libertaspeople/features/survey/survey_loading_indicator.dart';
import 'package:libertaspeople/features/survey/survey_thankyou_page.dart';
import 'package:libertaspeople/features/survey/widgets/next_previous_buttons.dart';
import 'package:libertaspeople/generated/l10n.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/shared_ui_elements/shared_ui_elements.dart';

import 'multiple_choice_button_column.dart';

class SurveyQuestionPage extends StatefulWidget {
  static const routeName = '/survey-question-page';

  final int questionIndex;
  final int totalQuestionCount;
  final QuestionModel question;
  final Map answer;

  const SurveyQuestionPage(
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

    if (widget.answer != null) {
      _answer = widget.answer as Map<String, dynamic>;
      if (_isTextEntryQuestion) {
        _textAnswerController.text = _answer[_question.questionId] as String;
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
              icon: const Icon(Icons.clear),
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SurveyThankYouPage()));
            } else if (state is FailureSurveyState) {
              ScaffoldMessenger.of(context).showSnackBar(
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 20),
                            // height: height * 0.35,
                            child: Text(
                              formatQuestionText(_question.display),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_isTextEntryQuestion)
                                  _buildTextFieldAnswerWidget()
                                else
                                  // _buildMCAnswerOptionsWidget(),
                                  MultipleChoiceButtonColumn(
                                    _question.questionId,
                                    _question.choices,
                                    updateAnswer:
                                        (Map<String, dynamic> answer) {
                                      _answer = answer;
                                    },
                                    previousAnswer: _answer,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  NextPreviousButtons(
                    isFinalQuestion: _questionIndex == _totalCount,
                    isFirstQuestion: _questionIndex == 1,
                    onBackPressed: () {
                      context.read<SurveyCubit>().previousQuestion();
                    },
                    onNextPressed: () {
                      // validate a button has been pressed or a text has been entered

                      if (_answer == null) {
                        ScaffoldMessenger.of(_scaffoldKey.currentContext)
                            .showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 1500),
                            content:
                                Text(S.of(context).pleaseProvideAnAnswerThanks),
                          ),
                        );
                        return;
                      }

                      final isFinalQuestion = _questionIndex == _totalCount;

                      if (isFinalQuestion) {
                        context.read<SurveyCubit>().completeSurvey(_answer);
                      } else {
                        context.read<SurveyCubit>().nextQuestion(_answer);
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

  Widget _buildTextFieldAnswerWidget() {
    return TextField(
        controller: _textAnswerController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        onChanged: (newValue) {
          _answer = {_question.questionId: newValue};
        });
  }

  String formatQuestionText(String text) {
    return text.replaceAll('<br>', '\n').replaceAll('&nbsp;', ' ');
  }

  Future<bool> _onBackPressed(BuildContext context) {
    showDialog(
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
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              S.of(context).continueText,
              style:
                  const TextStyle(color: AppColors.blueAboutPage, fontSize: 17),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => TabBarController()),
                  (route) => route.isFirst);
            },
            child: Text(
              S.of(context).leave,
              style:
                  const TextStyle(color: AppColors.blueAboutPage, fontSize: 17),
            ),
          ),
        ],
      ),
    );
    return Future.value(false);
  }
}
