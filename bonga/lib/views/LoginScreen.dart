import 'package:bonga/constants.dart';
import 'package:flutter/material.dart';

import 'components/FormField.dart';
import 'components/MajorButton.dart';

class LoginScreen extends StatelessWidget {
  // TODO: Code Horizontal Layout for this screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: LoginScreenForm(),
          ),
        ),
      ),
    );
  }
}

class LoginScreenForm extends StatefulWidget {
  @override
  _LoginScreenFormState createState() => _LoginScreenFormState();
}

class _LoginScreenFormState extends State<LoginScreenForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  bool _passwordVisibilityValue = true;

  void _passwordVisible() {
    setState(() {
      _passwordVisibilityValue = !_passwordVisibilityValue;
    });
  }

  void _homeNavigator(BuildContext context) {
    Navigator.pop(context, true);
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  void dispose() {
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          AuthFormField(
            textFieldController: _emailTextFieldController,
            hintText: 'Email Address',
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
            passwordFieldFunction: _passwordVisible,
            maskText: _passwordVisibilityValue,
          ),
          SizedBox(
            height: kSizeSetter(context, 'Height', 0.05),
          ),
          MajorButton(
            onPress: () {
              _homeNavigator(context);
            },
            buttonColour: kDarkPrimaryColour,
            buttonTextColour: kTextPrimaryColour,
            buttonText: 'LOGIN',
            buttonWidth: kSizeSetter(context, 'Width', kAuthButtonWidthRatio),
            buttonHeight:
                kSizeSetter(context, 'Height', kAuthButtonHeightRatio),
          ),
        ],
      ),
    );
  }
}
