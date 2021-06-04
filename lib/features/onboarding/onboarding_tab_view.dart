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
        Expanded(
          child: isSvg ? SvgPicture.asset(imagePath) : Image.asset(imagePath),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  topText,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.orange),
                ),
                const SizedBox(height: 25),
                Text(
                  bottomText,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: const TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
