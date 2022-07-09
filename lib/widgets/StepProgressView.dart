import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class StepProgressView extends StatelessWidget {
  //height of the container
  final double _height;
//width of the container
  final double _width;
//container decoration
  final BoxDecoration decoration;
//list of texts to be shown for each step
  final List<String> _stepsText;
//cur step identifier
  final int _curStep;
//active color
  final Color _activeColor;
//in-active color
  final Color _inactiveColor;
//dot radius
  final double _dotRadius;
//container padding
  final EdgeInsets padding;
//line height
  final double lineHeight;
//header textstyle
  final TextStyle _headerStyle;
//steps text
  final TextStyle _stepStyle;

  const StepProgressView(
    List<String> stepsText,
    int curStep,
    double height,
    double width,
    double dotRadius,
    Color activeColor,
    Color inactiveColor,
    TextStyle headerStyle,
    TextStyle stepsStyle, {
    required this.decoration,
    required this.padding,
    this.lineHeight = 2.0,
  })  : _stepsText = stepsText,
        _curStep = curStep,
        _height = height,
        _width = width,
        _dotRadius = dotRadius,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _headerStyle = headerStyle,
        _stepStyle = stepsStyle,
        assert(curStep > 0 == true && curStep <= stepsText.length),
        assert(width > 0),
        assert(height >= 2 * dotRadius),
        assert(width >= dotRadius * 2 * stepsText.length);

  List<Widget> _buildDots() {
    var wids = <Widget>[];
    _stepsText.asMap().forEach((i, text) {
      var circleColor =
          (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;

      var lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;

      wids.add(
        CircleAvatar(
          radius: _dotRadius,
          backgroundColor: circleColor,
        ),
      );

      //add a line separator
      //0-------0--------0
      if (i != _stepsText.length - 1) {
        wids.add(
          Expanded(
            child: Container(
              height: lineHeight,
              color: lineColor,
            ),
          ),
        );
      }
    });

    return wids;
  }

  List<Widget> _buildText() {
    var wids = <Widget>[];
    _stepsText.asMap().forEach((i, text) {
      wids.add(
        Text(
          text,
          style: _stepStyle,
        ),
      );
    });

    return wids;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: this._height,
      width: this._width,
      decoration: this.decoration,
      child: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: (_curStep).toString(),
                      style: _headerStyle.copyWith(
                        color: _activeColor, //this is always going to be active
                      ),
                    ),
                    TextSpan(
                      text: " / " + _stepsText.length.toString(),
                      style: _headerStyle.copyWith(
                        color: _curStep == _stepsText.length
                            ? _activeColor
                            : _inactiveColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: _buildDots(),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildText(),
          )
        ],
      ),
    );
  }
}
