import 'package:bonga/constants.dart';
import 'package:flutter/material.dart';

import 'components/FormField.dart';
import 'components/MajorButton.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: kSizeSetter(context, 'Height', 0.8),
          child: SingleChildScrollView(
            child: RegistrationScreenForm(),
          ),
        ),
      ),
    );
  }
}

class RegistrationScreenForm extends StatelessWidget {
  static final _registrationFormKey = GlobalKey<FormState>();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final _confirmPasswordTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registrationFormKey,
      child: Column(
        children: [
          SizedBox(
            height: kSizeSetter(context, 'Height', 0.1),
          ),
          AuthFormField(
            textFieldController: _emailTextFieldController,
            hintText: 'Enter your email address',
            emptyFieldValidatorError: kEmptyEmailValidatorError,
            invalidFieldValidatorError: kInvalidEmailValidatorError,
            keyboardType: TextInputType.emailAddress,
            isPasswordField: false,
          ),
          SizedBox(
            height: kSizeSetter(context, 'Height', 0.05),
          ),
          AuthFormField(
            textFieldController: _passwordTextFieldController,
            hintText: 'Password',
            emptyFieldValidatorError: kEmptyPasswordValidatorError,
            invalidFieldValidatorError: kInvalidPasswordValidatorError,
            keyboardType: TextInputType.visiblePassword,
            isPasswordField: true,
          ),
          SizedBox(
            height: kSizeSetter(context, 'Height', 0.05),
          ),
          AuthFormField(
            textFieldController: _confirmPasswordTextFieldController,
            hintText: 'Re-enter your password',
            emptyFieldValidatorError: kEmptyPasswordValidatorError,
            invalidFieldValidatorError: kInvalidPasswordValidatorError,
            keyboardType: TextInputType.visiblePassword,
            isPasswordField: true,
          ),
          SizedBox(
            height: kSizeSetter(context, 'Height', 0.05),
          ),
          MajorButton(
            onPress: null,
            buttonColour: kDarkPrimaryColour,
            buttonTextColour: kTextPrimaryColour,
            buttonText: 'REGISTER',
            buttonWidth: kSizeSetter(context, 'Width', kAuthButtonWidthRatio),
            buttonHeight:
                kSizeSetter(context, 'Height', kAuthButtonHeightRatio),
          ),
        ],
      ),
    );
  }
}
