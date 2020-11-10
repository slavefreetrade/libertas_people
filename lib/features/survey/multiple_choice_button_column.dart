import 'package:flutter/material.dart';
import 'package:libertaspeople/models/choice_model.dart';
import 'package:libertaspeople/shared_ui_elements/colors.dart';

class MultipleChoiceButtonColumn extends StatefulWidget {
  final String questionId;
  final List<ChoiceModel> choices;
  final Function(Map<String, dynamic> answer) updateAnswer;
  final Map<String, dynamic> previousAnswer;

  const MultipleChoiceButtonColumn(
    this.questionId,
    this.choices, {
    @required this.updateAnswer,
        this.previousAnswer,
  });

  @override
  _MultipleChoiceButtonColumnState createState() =>
      _MultipleChoiceButtonColumnState();
}

class _MultipleChoiceButtonColumnState
    extends State<MultipleChoiceButtonColumn> {
  String _toggledId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.previousAnswer != null) {
      print("previous answer: ${widget.previousAnswer}");
      print("previous toggled index: ${widget.previousAnswer[widget.questionId].keys.first}");
      setState(() {
        _toggledId = widget.previousAnswer[widget.questionId].keys.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildMCAnswerOptionsWidget();
  }

  _buildMCAnswerOptionsWidget() {
    List<Widget> questionChoiceButtons = [];

    widget.choices.forEach((choice) {
      questionChoiceButtons.add(FlatButton(
        onPressed: () {
          setState(() {
            _toggledId = choice.choiceId;
          });
          Map<String, dynamic> answer = {
            widget.questionId: {
              choice.choiceId: {"selected": true}
            }
          };
          // print("selected answer: $answer");
          // print("value for id: ${answer[widget.questionId].keys.first}");

          widget.updateAnswer(answer);

        },
        padding: const EdgeInsets.all(12.0),
        color: _toggledId == choice.choiceId
            ? AppColors.darkBlue
            : AppColors.white,
        child: Text(
          choice.display,
          style: TextStyle(
              fontSize: 20,
              color: _toggledId == choice.choiceId
                  ? AppColors.white
                  : AppColors.darkBlue,
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
}
