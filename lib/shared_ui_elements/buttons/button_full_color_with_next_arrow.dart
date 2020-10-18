import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'base_button_widget.dart';

class ButtonFullColorWithNextArrow extends BaseButton {
  final Function() onPressed;
  final String label;

  const ButtonFullColorWithNextArrow(
      {@required this.onPressed, @required this.label, Key key})
      : assert(label != null, 'ButtonFullColor text input should not be null'),
        assert(onPressed != null,
            'ButtonFullColor onPressed input should not be null'),
        super(
            onPressedBtn: onPressed,
            labelBtn: label,
            isRightArrowBtn: true,
            colorBtn: ColorConstants.lightBlue,
            colorTxt: ColorConstants.white,
            colorBorder: ColorConstants.lightBlue,
            key: key);
}
