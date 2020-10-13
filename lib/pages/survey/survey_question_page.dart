import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/pages/survey/survey_cubit.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SurveyQuestionPage extends StatefulWidget {
  static const routeName = '/survey-question-page';

  final int questionIndex;
  final int totalQuestionCount;
  final QuestionModel question;

  SurveyQuestionPage(this.questionIndex, this.totalQuestionCount, this.question);

  @override
  _SurveyQuestionPageState createState() => _SurveyQuestionPageState();
}

class _SurveyQuestionPageState extends State<SurveyQuestionPage> {
  var incr = 0;
  bool _toggleYes = false;
  bool _toggleNo = false;
  bool _toggleNext = false;
  bool _togglePrev = false;

  int get _questionIndex => widget.questionIndex;
  int get _totalCount => widget.totalQuestionCount;
  QuestionModel get _question => widget.question;

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
                onTap: () => Navigator.of(context).pop(true),
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.darkBlue,
            title: Text("${widget.questionIndex}/${widget.totalQuestionCount}"),
            centerTitle: true,
          ),
          body: Container(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StepProgressIndicator(
                    totalSteps: _totalCount,
                    currentStep: _questionIndex,
                    size: 20,
                    selectedColor: ColorConstants.lightBlue,
                    unselectedColor: Colors.grey,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    height: height * 0.35,
                    child: Text(
                      _question.display,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _toggleYes = true;
                        _toggleNo = false;
                      });
                    },
                    padding: const EdgeInsets.all(12.0),
                    color: _toggleYes
                        ? ColorConstants.darkBlue
                        : ColorConstants.white,
                    child: Text(
                      "Yes",
                      style: TextStyle(
                          fontSize: 20,
                          color: _toggleYes
                              ? ColorConstants.white
                              : ColorConstants.darkBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey,
                            width: 3,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _toggleNo = true;
                        _toggleYes = false;
                      });
                    },
                    padding: const EdgeInsets.all(12.0),
                    color: _toggleNo
                        ? ColorConstants.darkBlue
                        : ColorConstants.white,
                    child: Text(
                      "No",
                      style: TextStyle(
                          fontSize: 20,
                          color: _toggleNo
                              ? ColorConstants.white
                              : ColorConstants.darkBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey,
                            width: 3,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.15),
                    child: Row(
                      children: [
                        Expanded(
                          child: FlatButton.icon(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              setState(() {
                                _togglePrev = true;
                                _toggleNext = false;
                              });
                            },
                            padding: const EdgeInsets.all(10.0),
                            textColor: _togglePrev
                                ? ColorConstants.white
                                : ColorConstants.lightBlue,
                            color: _togglePrev
                                ? ColorConstants.lightBlue
                                : ColorConstants.white,
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
                              setState(() {
                                _toggleNext = true;
                                _togglePrev = false;
                                // _attemptedQuestion = _attemptedQuestion + 1;
                              });
                            },
                            padding: const EdgeInsets.all(10.0),
                            textColor: _toggleNext
                                ? ColorConstants.white
                                : ColorConstants.lightBlue,
                            color: _toggleNext
                                ? ColorConstants.lightBlue
                                : ColorConstants.white,
                            label: const Text(
                              "Next",
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
