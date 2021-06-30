import 'package:bonga/constants.dart';
import 'package:flutter/material.dart';

import 'components/form_field.dart';
import 'components/major_button.dart';

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

class RegistrationScreenForm extends StatefulWidget {
  @override
  _RegistrationScreenFormState createState() => _RegistrationScreenFormState();
}

class _RegistrationScreenFormState extends State<RegistrationScreenForm> {
  final _registrationFormKey = GlobalKey<FormState>();

  final _emailTextFieldController = TextEditingController();

  final _passwordTextFieldController = TextEditingController();

  final _confirmPasswordTextFieldController = TextEditingController();

  void _homeNavigator(BuildContext context) {
    Navigator.pop(context, true);
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

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
            onPress: () {
              if (_registrationFormKey.currentState!.validate()) {
                _homeNavigator(context);
              }
            },
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
