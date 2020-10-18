import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import 'base_button_widget.dart';

class ButtonBorderedWithBackArrow extends BaseButton {
  final Function() onPressed;
  final String label;

  const ButtonBorderedWithBackArrow(
      {@required this.onPressed,
      @required this.label,
      Key key})
      : assert(label != null, 'ButtonBordered text input should not be null'),
        assert(onPressed != null, 'ButtonBordered onPressed input should not be null'),
        super(
          onPressedBtn: onPressed,
          labelBtn: label,
          isLeftArrowBtn: true,
          colorBtn: ColorConstants.white,
          colorTxt: ColorConstants.lightBlue,
          colorBorder: ColorConstants.lightBlue,
          key: key);
}
