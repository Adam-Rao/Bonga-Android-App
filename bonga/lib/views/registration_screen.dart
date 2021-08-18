import 'package:bonga/constants.dart';
import 'package:bonga/controllers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'components/form_field.dart';
import 'components/major_button.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: RegistrationScreenForm(),
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

  void _registerNewUser(BuildContext context) async {
    if (_passwordTextFieldController.text !=
        _confirmPasswordTextFieldController.text) {
      Fluttertoast.showToast(msg: 'Passwords not matching');
    } else {
      bool userConnected = await kCheckConnectivity();

      if (userConnected) {
        Authentication.registerUser(
          _emailTextFieldController.text,
          _confirmPasswordTextFieldController.text,
        );
        Navigator.pop(context, true);
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        Fluttertoast.showToast(msg: 'No internet connextion');
      }
    }
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
                _registerNewUser(context);
              }
            },
            buttonColour: kDarkPrimaryColour,
            buttonTextColour: kTextPrimaryColour,
            buttonText: 'REGISTER',
            buttonWidth: kSizeSetter(context, 'Width', kAuthButtonWidthRatio),
            buttonHeight:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? kSizeSetter(context, 'Height', kAuthButtonHeightRatio)
                    : kSizeSetter(context, 'Height', 0.15),
          ),
        ],
      ),
    );
  }
}
