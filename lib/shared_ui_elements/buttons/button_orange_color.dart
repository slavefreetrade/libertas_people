import 'package:flutter/material.dart';

import '../colors.dart';

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
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(8),
        backgroundColor: MaterialStateProperty.all(AppColors.orange),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(label),
      ),
    );
  }
}
