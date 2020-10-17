import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/models/choice_model.dart';
import 'package:libertaspeople/models/question_model.dart';

class MultipleChoiceButtonColumn extends StatefulWidget {
  final String questionId;
  final List<ChoiceModel> choices;
  final Function(Map<String, dynamic> answer) updateAnswer;

  const MultipleChoiceButtonColumn(
    this.questionId,
    this.choices, {
    @required this.updateAnswer,
  });

  @override
  _MultipleChoiceButtonColumnState createState() =>
      _MultipleChoiceButtonColumnState();
}

class _MultipleChoiceButtonColumnState
    extends State<MultipleChoiceButtonColumn> {
  String _toggledId;

  // on tapping button, set toggleId to that choices ID, and then call callback to update parent

  @override
  Widget build(BuildContext context) {
    return _buildMCAnswerOptionsWidget();
  }

  // internal state will only be responsible for highlighting buttons
  // will update parent state via callback
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
          widget.updateAnswer(answer);
        },
        padding: const EdgeInsets.all(12.0),
        color: _toggledId == choice.choiceId
            ? ColorConstants.darkBlue
            : ColorConstants.white,
        child: Text(
          choice.display,
          style: TextStyle(
              fontSize: 20,
              color: _toggledId == choice.choiceId
                  ? ColorConstants.white
                  : ColorConstants.darkBlue,
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
