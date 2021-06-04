import 'package:bonga/views/components/Text.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class MajorButton extends StatelessWidget {
  final Function()? _onPress;
  final Color? _buttonColour;
  final Color? _buttonTextColour;
  final String? _buttonText;
  final double? _buttonWidth;
  final double? _buttonHeight;

  const MajorButton(
      {Key? key,
      @required Function()? onPress,
      @required Color? buttonColour,
      @required Color? buttonTextColour,
      @required String? buttonText,
      @required double? buttonWidth,
      @required double? buttonHeight})
      : _onPress = onPress,
        _buttonColour = buttonColour,
        _buttonTextColour = buttonTextColour,
        _buttonText = buttonText,
        _buttonWidth = buttonWidth,
        _buttonHeight = buttonHeight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPress,
      child: AppText(
        _buttonText!,
        kFontWeightSemiBold,
        18.0,
        _buttonTextColour!,
      ),
      style: ElevatedButton.styleFrom(
        primary: _buttonColour,
        minimumSize: Size(
          _buttonWidth!,
          _buttonHeight!,
        ),
      ),
    );
  }
}
