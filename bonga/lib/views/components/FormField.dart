import 'package:flutter/material.dart';

import '../../constants.dart';

class AuthFormField extends StatefulWidget {
  const AuthFormField({
    Key? key,
    required TextEditingController textFieldController,
    required String hintText,
    required String emptyFieldValidatorError,
    required String invalidFieldValidatorError,
    required TextInputType keyboardType,
    required bool isPasswordField,
  })  : _textFieldController = textFieldController,
        _hintText = hintText,
        _emptyFieldValidatorError = emptyFieldValidatorError,
        _invalidFieldValidatorError = invalidFieldValidatorError,
        _keyboardType = keyboardType,
        _isPasswordField = isPasswordField,
        super(key: key);

  final TextEditingController _textFieldController;
  final String _hintText;
  final String _emptyFieldValidatorError;
  final String _invalidFieldValidatorError;
  final TextInputType _keyboardType;
  final bool _isPasswordField;

  @override
  _AuthFormFieldState createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  @override
  void dispose() {
    widget._textFieldController.dispose();
    super.dispose();
  }

  bool _passwordObscured = true;

  void _obscurePassword() {
    setState(() {
      _passwordObscured = !_passwordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._textFieldController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: kTextPrimaryColour,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kDefaultPrimaryColour,
          ),
        ),
        hintText: widget._hintText,
        hintStyle: TextStyle(
          fontFamily: kFontFamily,
          fontSize: kHintTextSize,
          fontWeight: kFontWeightSemiBold,
        ),
        suffixIcon: widget._isPasswordField == true
            ? IconButton(
                icon: Icon(Icons.visibility_rounded),
                onPressed: _obscurePassword,
              )
            : null,
      ),
      keyboardType: widget._keyboardType,
      obscureText: widget._isPasswordField == true ? _passwordObscured : false,
      style: TextStyle(
        color: kPrimaryTextColour,
        fontFamily: kFontFamily,
        fontSize: 16.0,
        fontWeight: kFontWeightRegular,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget._emptyFieldValidatorError;
        }

        if (widget._isPasswordField == true) {
          if (!kPasswordRegExPattern.hasMatch(value)) {
            return widget._invalidFieldValidatorError;
          }
        } else {
          if (!kEmailRegExPattern.hasMatch(value)) {
            return widget._invalidFieldValidatorError;
          }
        }

        return null;
      },
    );
  }
}
