import 'package:bonga/constants.dart';
import 'package:bonga/controllers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'components/form_field.dart';
import 'components/major_button.dart';

class LoginScreen extends StatelessWidget {
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

class LoginScreenForm extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  void _loginUser(BuildContext context) async {
    bool userConnected = await kCheckConnectivity();

    if (userConnected) {
      Authentication.loginUser(
        _emailTextFieldController.text,
        _passwordTextFieldController.text,
      );
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      Fluttertoast.showToast(msg: 'No internet connection');
    }
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
          ),
          SizedBox(
            height: kSizeSetter(context, 'Height', 0.05),
          ),
          MajorButton(
            onPress: () {
              if (_loginFormKey.currentState!.validate()) {
                _loginUser(context);
              }
            },
            buttonColour: kDarkPrimaryColour,
            buttonTextColour: kTextPrimaryColour,
            buttonText: 'LOGIN',
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
