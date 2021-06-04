import 'package:flutter/material.dart';
import 'package:libertaspeople/models/choice_model.dart';
import 'package:libertaspeople/shared_ui_elements/shared_ui_elements.dart';

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
    super.initState();
    if (widget.previousAnswer != null) {
      setState(() {
        _toggledId =
            widget.previousAnswer[widget.questionId].keys.first as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildMCAnswerOptionsWidget();
  }

  Widget buildMCAnswerOptionsWidget() {
    final List<Widget> questionChoiceButtons = [];

    for (final choice in widget.choices) {
      questionChoiceButtons.add(TextButton(
        onPressed: () {
          setState(() {
            _toggledId = choice.choiceId;
          });
          final Map<String, dynamic> answer = {
            widget.questionId: {
              choice.choiceId: {"selected": true}
            }
          };

          widget.updateAnswer(answer);
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(12.0),
          ),
          backgroundColor: MaterialStateProperty.all(
            _toggledId == choice.choiceId
                ? AppColors.darkBlue
                : AppColors.white,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.darkBlue),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        child: Text(
          choice.display,
          style: TextStyle(
              fontSize: 20,
              color: _toggledId == choice.choiceId
                  ? AppColors.white
                  : AppColors.darkBlue,
              fontWeight: FontWeight.bold),
        ),
      ));
      questionChoiceButtons.add(
        const SizedBox(
          height: 20,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: questionChoiceButtons,
    );
  }
}
