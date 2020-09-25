import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import '../../../constants/colors.dart';

class HeaderProgressBar extends StatefulWidget {
  const HeaderProgressBar(
      {Key key,
        this.currentValue = 0,
        this.maxValue = 100,
        this.size = 20,
        this.animatedDuration = const Duration(milliseconds: 300),
        this.direction = Axis.horizontal,
        this.verticalDirection = VerticalDirection.down,
        this.borderRadius = 0,
        this.border,
        this.backgroundColor = ColorConstants.greyAboutPage,
        this.progressColor = ColorConstants.lightBlue,
        this.changeColorValue,
        this.changeProgressColor = const Color(0xFF5F4B8B),
        this.displayText})
      : super(key: key);
  final int currentValue;
  final int maxValue;
  final double size;
  final Duration animatedDuration;
  final Axis direction;
  final VerticalDirection verticalDirection;
  final double borderRadius;
  final BoxBorder border;
  final Color backgroundColor;
  final Color progressColor;
  final int changeColorValue;
  final Color changeProgressColor;
  final String displayText;

  @override
  _HeaderProgressBarState createState() => _HeaderProgressBarState();
}

class _HeaderProgressBarState extends State<HeaderProgressBar>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  double _currentBegin = 0;
  double _currentEnd = 0;

  @override
  void initState() {
    _controller =
        AnimationController(duration: widget.animatedDuration, vsync: this);
    _animation = Tween<double>(begin: _currentBegin, end: _currentEnd)
        .animate(_controller);
    triggerAnimation();
    super.initState();
  }

  @override
  void didUpdateWidget(HeaderProgressBar old) {
    triggerAnimation();
    super.didUpdateWidget(old);
  }

  void triggerAnimation() {
    setState(() {
      _currentBegin = _animation.value;
      _currentEnd = widget.currentValue / widget.maxValue;
      _animation = Tween<double>(begin: _currentBegin, end: _currentEnd)
          .animate(_controller);
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) => _AnimatedProgressBar(
    animation: _animation,
    widget: widget,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _AnimatedProgressBar extends AnimatedWidget {
  const _AnimatedProgressBar({
    Key key,
    Animation<double> animation,
    this.widget,
  }) : super(key: key, listenable: animation);
  final HeaderProgressBar widget;

  double transformValue(double x, int begin, int end, int before) {
    final y = (end * x - (begin - before)) * (1 / before);
    return y < 0 ? 0 : ((y > 1) ? 1 : y);
  }

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    var progressColor = widget.progressColor;

    if (widget.changeColorValue != null) {
      final _colorTween = ColorTween(
          begin: widget.progressColor, end: widget.changeProgressColor);
      progressColor = _colorTween.transform(transformValue(
          animation.value, widget.changeColorValue, widget.maxValue, 5));
    }

    final progressWidgets = <Widget>[];
    final Widget progressWidget = Container(
      decoration: BoxDecoration(
          color: progressColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: widget.border),
    );
    progressWidgets.add(progressWidget);

    if (widget.displayText != null) {
      final Widget textProgress = Container(
          alignment: widget.direction == Axis.horizontal
              ? const FractionalOffset(0.95, 0.5)
              : (widget.verticalDirection == VerticalDirection.up
              ? const FractionalOffset(0.5, 0.05)
              : const FractionalOffset(0.5, 0.95)),
          child: Text(
              (animation.value * widget.maxValue).toInt().toString() +
                  widget.displayText,
              softWrap: false,
              style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 12)));
      progressWidgets.add(textProgress);
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: widget.direction == Axis.vertical ? widget.size : null,
        height: widget.direction == Axis.horizontal ? widget.size : null,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: widget.border,
        ),
        child: Flex(
          direction: widget.direction,
          verticalDirection: widget.verticalDirection,
          children: <Widget>[
            Expanded(
                flex: (animation.value * 100).toInt(),
                child: Stack(children: progressWidgets)),
            Expanded(
              flex: 100 - (animation.value * 100).toInt(),
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
