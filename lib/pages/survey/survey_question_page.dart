import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/pages/home/home_page.dart';
import 'package:libertaspeople/pages/survey/multiple_choice_button_column.dart';
import 'package:libertaspeople/pages/survey/survey_cubit.dart';
import 'package:libertaspeople/pages/survey/survey_loading_indicator.dart';
import 'package:libertaspeople/pages/survey_thankyou_page.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
  var incr = 0;
  bool _toggleYes = false;

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

    _answer = widget.answer;
    print("_answer in survey quewiton page: ${_answer}");
    if (_answer != null) {
      if (_isTextEntryQuestion) {
        setState(() {
          _answer = {_question.questionId: _answer[_question.questionId]};
          _textAnswerController.text = _answer[_question.questionId];
        });
      } else {
        // todo handel setting previous answer here for MC
        print("handle setting previous MC answer");
      }
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
            "${widget.questionIndex}/${widget.totalQuestionCount} : ${_question.questionId}"),
        centerTitle: true,
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

  // internal state will only be responsible for highlighting buttons
  // will update parent state via callback
  _buildMCAnswerOptionsWidget() {
    List<Widget> questionChoiceButtons = [];

    _question.choices.forEach((choice) {
      questionChoiceButtons.add(FlatButton(
        onPressed: () {
          setState(() {

            _answer = {
              _question.questionId: {
                choice.choiceId: {"selected": true}
              }
            };
          });
        },
        padding: const EdgeInsets.all(12.0),
        color: _toggleYes ? ColorConstants.darkBlue : ColorConstants.white,
        child: Text(
          choice.display,
          style: TextStyle(
              fontSize: 20,
              color:
                  _toggleYes ? ColorConstants.white : ColorConstants.darkBlue,
              fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.grey, width: 3, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
      ));
      questionChoiceButtons.add(
        const SizedBox(
          height: 20,
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: questionChoiceButtons,
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Are you sure want to leave?',
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'It will only take a couple more minutes to finish.If you leave,your answers will be saved.',
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: const Text(
                  "Continue",
                  style: const TextStyle(
                      color: ColorConstants.blueAboutPage, fontSize: 17),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
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
