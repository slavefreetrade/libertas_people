import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../shared_ui_elements/colors.dart';

class OnBoardingTabView extends StatelessWidget {
  final String topText;
  final String bottomText;
  final String imagePath;
  final bool isSvg;

  const OnBoardingTabView({
    Key key,
    @required this.topText,
    @required this.bottomText,
    @required this.imagePath,
    this.isSvg = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            topText,
            softWrap: true,
            textAlign: TextAlign.justify,
            style: const TextStyle(
                color: AppColors.darkBlue,
                fontSize: 17,
                fontWeight: FontWeight.w300,
                wordSpacing: 3.5),
          ),
        ),
        const SizedBox(height: 25),
        Expanded(
          child: isSvg ? SvgPicture.asset(imagePath) : Image.asset(imagePath),
        ),
        const SizedBox(height: 25),
        Text(
          bottomText,
          textAlign: TextAlign.justify,
          softWrap: true,
          style: const TextStyle(
              color: AppColors.darkBlue,
              fontSize: 17,
              fontWeight: FontWeight.w300,
              wordSpacing: 3.5),
        ),
      ],
    );
  }
}
