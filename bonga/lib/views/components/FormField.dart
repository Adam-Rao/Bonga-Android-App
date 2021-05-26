import 'package:flutter/material.dart';

import '../../constants.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField(
      {Key key,
      @required TextEditingController textFieldController,
      @required String hintText,
      @required String emptyFieldValidatorError,
      @required String invalidFieldValidatorError,
      @required TextInputType keyboardType,
      @required bool isPasswordField,
      Function passwordFieldFunction,
      bool maskText})
      : _textFieldController = textFieldController,
        _hintText = hintText,
        _emptyFieldValidatorError = emptyFieldValidatorError,
        _invalidFieldValidatorError = invalidFieldValidatorError,
        _keyboardType = keyboardType,
        _isPasswordField = isPasswordField,
        _passwordFieldFunction = passwordFieldFunction,
        _maskText = maskText,
        super(key: key);

  final TextEditingController _textFieldController;
  final String _hintText;
  final String _emptyFieldValidatorError;
  final String _invalidFieldValidatorError;
  final TextInputType _keyboardType;
  final bool _isPasswordField;
  final Function _passwordFieldFunction;
  final bool _maskText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textFieldController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: kTextPrimaryColour,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kDefaultPrimaryColour,
          ),
        ),
        hintText: _hintText,
        hintStyle: TextStyle(
          fontFamily: kFontFamily,
          fontSize: kHintTextSize,
          fontWeight: kFontWeightSemiBold,
        ),
        suffixIcon: _isPasswordField == true
            ? IconButton(
                icon: Icon(Icons.visibility_rounded),
                onPressed: _passwordFieldFunction,
              )
            : null,
      ),
      keyboardType: _keyboardType,
      obscureText: _isPasswordField == true ? _maskText : false,
      style: TextStyle(
        color: kPrimaryTextColour,
        fontFamily: kFontFamily,
        fontSize: 16.0,
        fontWeight: kFontWeightRegular,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return _emptyFieldValidatorError;
        } else if (!kEmailRegExPattern.hasMatch(value)) {
          return _invalidFieldValidatorError;
        }
        return null;
      },
    );
  }
}
