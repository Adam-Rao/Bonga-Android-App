import 'package:flutter/material.dart';

import '../../constants.dart';

class AppText extends StatelessWidget {
  final String _title;
  final FontWeight _fontWeight;
  final double _fontSize;
  final Color _colour;

  const AppText(this._title, this._fontWeight, this._fontSize, this._colour);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        color: _colour,
        fontFamily: kFontFamily,
        fontWeight: _fontWeight,
        fontSize: _fontSize,
      ),
    );
  }
}
