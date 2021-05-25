import 'package:flutter/material.dart';
import 'package:libertaspeople/shared_ui_elements/shared_ui_elements.dart';

class NextPreviousButtons extends StatelessWidget {
  final bool isFirstQuestion;
  final bool isFinalQuestion;
  final String previousButtonLabel;
  final Function() onBackPressed;
  final Function() onNextPressed;

  const NextPreviousButtons(
      {Key key,
      this.isFirstQuestion = false,
      this.isFinalQuestion = false,
      this.previousButtonLabel,
      @required this.onBackPressed,
      @required this.onNextPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: isFirstQuestion
                ? Container()
                : ButtonBorderedWithBackArrow(
                    onPressed: onBackPressed,
                    previousButtonLabel: previousButtonLabel,
                  ),
          ),
          const Spacer(),
          Expanded(
            flex: 5,
            child: ButtonFullColorWithNextArrow(
              onPressed: onNextPressed,
              isFinalQuestion: isFinalQuestion,
            ),
          ),
        ],
      ),
    );
  }
}
