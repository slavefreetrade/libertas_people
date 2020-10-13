import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/pages/survey/survey_cubit.dart';
import 'package:libertaspeople/pages/survey/survey_thankyou_page.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SurveyQuestionPage extends StatefulWidget {
  static const routeName = '/survey-question-page';

  final int questionIndex;
  final int totalQuestionCount;
  final QuestionModel question;

  SurveyQuestionPage(
      this.questionIndex, this.totalQuestionCount, this.question);

  @override
  _SurveyQuestionPageState createState() => _SurveyQuestionPageState();
}

class _SurveyQuestionPageState extends State<SurveyQuestionPage> {
  var incr = 0;
  bool _toggleYes = false;
  bool _toggleNo = false;

  int get _questionIndex => widget.questionIndex;

  int get _totalCount => widget.totalQuestionCount;

  QuestionModel get _question => widget.question;

  final TextEditingController _textAnswerController = TextEditingController();

  bool get _isTextEntryQuestion => _question.choices == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.clear), onPressed: _onBackPressed),
        backgroundColor: ColorConstants.darkBlue,
        title: Text("${widget.questionIndex}/${widget.totalQuestionCount}"),
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
                    state.question),
              ),
            );
          }
          if (state is ThankYouSurveyState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SurveyThankyouPage()));
          }

          if (state is FailureSurveyState) {
            print(state.message);
            // TODO display to user the error and probably exit survey?
          }
        },
        child: Container(
          // width: width,
          // height: height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: StepProgressIndicator(
                    totalSteps: _totalCount,
                    currentStep: _questionIndex,
                    size: 20,
                    selectedColor: ColorConstants.lightBlue,
                    unselectedColor: Colors.grey,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  // height: height * 0.35,
                  child: Text(
                    _question.display,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isTextEntryQuestion)
                        _buildTextFieldAnswerWidget()
                      else
                        _buildMCAnswerOptionsWidget(),
                    ],
                  ),
                ),
                _nextAndPreviousButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _nextAndPreviousButtons() {
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
                      // TODO implement going backwards
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

                var answer;
                if(_isTextEntryQuestion) {
                  answer = {_question.questionId: _textAnswerController.text};
                }

                context.bloc<SurveyCubit>().nextQuestion(answer);

                // setState(() {
                  // TODO implement going forward
                // });
              },
              padding: const EdgeInsets.all(10.0),
              textColor: ColorConstants.white,
              color: ColorConstants.lightBlue,
              label: const Text(
                "Next",
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
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  _buildMCAnswerOptionsWidget() {
    List<Widget> questionChoiceButtons = [];

    _question.choices.forEach((choice) {
      questionChoiceButtons.add(FlatButton(
        onPressed: () {




          setState(() {
            _toggleYes = true;
            _toggleNo = false;
          });
        },
        padding: const EdgeInsets.all(12.0),
        color: _toggleYes ? ColorConstants.darkBlue : ColorConstants.white,
        child: Text(
          "Yes",
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

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: [
    //     FlatButton(
    //       onPressed: () {
    //         setState(() {
    //           _toggleYes = true;
    //           _toggleNo = false;
    //         });
    //       },
    //       padding: const EdgeInsets.all(12.0),
    //       color: _toggleYes ? ColorConstants.darkBlue : ColorConstants.white,
    //       child: Text(
    //         "Yes",
    //         style: TextStyle(
    //             fontSize: 20,
    //             color:
    //                 _toggleYes ? ColorConstants.white : ColorConstants.darkBlue,
    //             fontWeight: FontWeight.bold),
    //       ),
    //       shape: RoundedRectangleBorder(
    //           side: BorderSide(
    //               color: Colors.grey, width: 3, style: BorderStyle.solid),
    //           borderRadius: BorderRadius.circular(10)),
    //     ),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     FlatButton(
    //       onPressed: () {
    //         setState(() {
    //           _toggleNo = true;
    //           _toggleYes = false;
    //         });
    //       },
    //       padding: const EdgeInsets.all(12.0),
    //       color: _toggleNo ? ColorConstants.darkBlue : ColorConstants.white,
    //       child: Text(
    //         "No",
    //         style: TextStyle(
    //             fontSize: 20,
    //             color:
    //                 _toggleNo ? ColorConstants.white : ColorConstants.darkBlue,
    //             fontWeight: FontWeight.bold),
    //       ),
    //       shape: RoundedRectangleBorder(
    //           side: BorderSide(
    //               color: Colors.grey, width: 3, style: BorderStyle.solid),
    //           borderRadius: BorderRadius.circular(10)),
    //     )
    //   ],
    // );
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
}
