import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final bool isSelected;
  final double fontSize;
  final double padding;

  const AppFormField({
    Key key,
    @required this.label,
    this.isSelected = false,
    this.fontSize = 15,
    this.padding = 12
  })  : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: ColorConstants.darkBlue,
              border: Border.all(
                color: ColorConstants.darkBlue,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
                child: Text(
              label,
              style: TextStyle(
                  color: ColorConstants.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500),
            )),
          )
        : Container(
            width: double.infinity,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              border: Border.all(
                color: ColorConstants.greyAboutPage,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(label,
                  style: TextStyle(
                      color: ColorConstants.darkBlue,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500)),
            ));
  }
}
