import 'package:flutter/material.dart';

import '../../constants.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    Key? key,
    required TextEditingController fieldController,
    required String hintText,
    Widget? suffixIcon,
  })  : _fieldController = fieldController,
        _hintText = hintText,
        _suffixIcon = suffixIcon,
        super(key: key);

  final TextEditingController _fieldController;
  final String _hintText;
  final Widget? _suffixIcon;

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._fieldController,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: widget._hintText,
        hintStyle: TextStyle(
          fontFamily: kFontFamily,
          fontSize: kHintTextSize,
          fontWeight: kFontWeightRegular,
          color: Colors.grey,
        ),
        suffixIcon: widget._suffixIcon,
      ),
      style: TextStyle(
        color: kTextPrimaryColour,
        fontFamily: kFontFamily,
        fontSize: 16.0,
        fontWeight: kFontWeightRegular,
      ),
    );
  }
}
