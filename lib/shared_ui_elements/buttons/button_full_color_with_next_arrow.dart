import 'package:flutter/material.dart';
import 'package:libertaspeople/generated/l10n.dart';

import '../colors.dart';

class ButtonFullColorWithNextArrow extends StatelessWidget {
  final Function() onPressed;
  final bool isFinalQuestion;
  const ButtonFullColorWithNextArrow(
      {Key key, this.onPressed, this.isFinalQuestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
      textColor: AppColors.white,
      color: AppColors.lightBlue,
      child: Row(
        children: [
          Expanded(child: Text(
            isFinalQuestion ? S.of(context).complete : S.of(context).next,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: AppColors.lightBlue, width: 2, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
