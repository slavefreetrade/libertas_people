import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/generated/l10n.dart';

class ButtonBorderedWithBackArrow extends StatelessWidget {
  final Function() onPressed;
  final String previousButtonLabel;

  const ButtonBorderedWithBackArrow(
      {Key key, this.onPressed, this.previousButtonLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
      textColor: AppColors.lightBlue,
      color: AppColors.white,
      child: Row(
        children: [
          Expanded(
            child: const Icon(Icons.arrow_back_ios),
          ),
          Text(
            previousButtonLabel ?? S.of(context).previous,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: AppColors.lightBlue, width: 2, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
