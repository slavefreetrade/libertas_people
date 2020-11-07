import 'package:flutter/material.dart';
import 'package:libertaspeople/shared_ui_elements/buttons/button_bordered_with_back_arrow.dart';
import 'package:libertaspeople/shared_ui_elements/buttons/button_full_color_with_next_arrow.dart';

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
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: isFirstQuestion
                ? Container()
                : ButtonBorderedWithBackArrow(
                    onPressed: onBackPressed,
                    previousButtonLabel: previousButtonLabel,
                  ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
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
