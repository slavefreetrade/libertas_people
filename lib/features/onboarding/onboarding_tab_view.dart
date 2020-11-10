import 'package:flutter/material.dart';
import '../../shared_ui_elements/colors.dart';

class OnBoardingTabView extends StatelessWidget {
  final String topText;
  final String bottomText;
  final String imagePath;

  const OnBoardingTabView({
    Key key,
    @required this.topText,
    @required this.bottomText,
    @required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            topText,
            maxLines: 4,
            softWrap: true,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: AppColors.darkBlue,
                fontSize: 17.0,
                fontWeight: FontWeight.w300,
                wordSpacing: 3.5),
          ),
        ),
        Expanded(
          child: Image.asset(imagePath),
        ),
        Text(
          bottomText,
          textAlign: TextAlign.center,
          maxLines: 3,
          softWrap: true,
          style: const TextStyle(
              color: AppColors.darkBlue,
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              wordSpacing: 3.5),
        ),
      ],
    );
  }
}
