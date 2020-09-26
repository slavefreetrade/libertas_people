import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../shared/buttons/button_bordered_with_back_arrow.dart';
import '../shared/buttons/button_full_color_with_next_arrow.dart';

class BottomActionButtons extends StatelessWidget {
  const BottomActionButtons({
    Key key,
    @required this.onPressedBack,
    @required this.onPressedNext,
    this.showBack = true,
    this.showNext = true,
  })  : assert(onPressedBack != null,
            'onPressedBack should not be equal to null in BottomActionButtons'),
        assert(onPressedNext != null,
            'onPressedNext should not be equal to null in BottomActionButtons'),
        super(key: key);
  final Function() onPressedNext;
  final Function() onPressedBack;
  final bool showBack;
  final bool showNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (onPressedBack != null && showBack)
          ButtonBorderedWithBackArrow(
            label: S.of(context).back,
            onPressed: onPressedBack,
          )
        else
          const SizedBox.shrink(),
        if (onPressedNext != null && showNext)
          ButtonFullColorWithNextArrow(
            label: S.of(context).next,
            onPressed: onPressedNext,
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
