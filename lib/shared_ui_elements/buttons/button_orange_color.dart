import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';

class ButtonOrangeColor extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const ButtonOrangeColor({
    Key key,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: AppColors.orange,
      highlightElevation: 2,
      elevation: 8,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(label),
      ),
    );
  }
}
