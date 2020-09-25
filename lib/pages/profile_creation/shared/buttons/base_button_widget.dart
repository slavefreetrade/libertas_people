import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';

class BaseButton extends StatelessWidget {
  final Function() onPressedBtn;
  final String labelBtn;
  final bool isRightArrowBtn;
  final bool isLeftArrowBtn;
  final Color colorBtn;
  final Color colorTxt;
  final Color colorBorder;

  const BaseButton(
      {Key key,
      @required this.onPressedBtn,
      @required this.labelBtn,
      this.isRightArrowBtn = false,
      this.isLeftArrowBtn = false,
      this.colorBtn = Colors.black,
      this.colorBorder,
      this.colorTxt = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.zero,
      elevation: 0,
      shape: colorBorder == null
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: colorBorder, width: 2),
            ),
      color: colorBtn,
      onPressed: onPressedBtn,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isLeftArrowBtn)
            Row(
              children: [
                Icon(
                  Icons.chevron_left,
                  color: colorTxt,
                  size: 40,
                ),
                const SizedBox(width: 20),
              ],
            )
          else
            const SizedBox(width: 10),
          Text(
            labelBtn,
            style: TextStyle(
              color: colorTxt,
              fontWeight: FontWeight.w700,
              fontSize: 24, // double
            ),
          ),
          if (isRightArrowBtn)
            Row(
              children: [
                const SizedBox(width: 20),
                Icon(
                  Icons.chevron_right,
                  color: colorTxt,
                  size: 40,
                ),
              ],
            )
          else
            const SizedBox(width: 10),
        ],
      ),
    );
  }
}
