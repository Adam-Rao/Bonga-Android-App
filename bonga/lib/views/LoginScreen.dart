import 'package:bonga/constants.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTextFieldController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              fillColor: kTextPrimaryColour,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kDefaultPrimaryColour,
                ),
              ),
              hintText: 'Email address',
              hintStyle: TextStyle(
                  fontFamily: kFontFamily,
                  fontSize: kHintTextSize,
                  fontWeight: kFontWeightSemiBold),
            ),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: kPrimaryTextColour,
              fontFamily: kFontFamily,
              fontSize: 16.0,
              fontWeight: kFontWeightRegular,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email address';
              } else if (!kEmailRegExPattern.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          TextFormField(
            controller: _passwordTextFieldController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              fillColor: kTextPrimaryColour,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kDefaultPrimaryColour,
                ),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                fontFamily: kFontFamily,
                fontSize: kHintTextSize,
                fontWeight: kFontWeightSemiBold,
              ),
              suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_rounded),
                  onPressed: () {
                    setState(() {
                      _passwordVisibilityValue = !_passwordVisibilityValue;
                    });
                  }),
            ),
            obscureText: _passwordVisibilityValue,
            style: TextStyle(
              color: kPrimaryTextColour,
              fontFamily: kFontFamily,
              fontSize: 16.0,
              fontWeight: kFontWeightRegular,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              } else if (!kPasswordRegExPattern.hasMatch(value)) {
                return 'Password must have at least one: digit, upper case letter, lower case letter';
              }
              return null;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/home');
            },
            child: Text(
              'LOGIN',
              style: TextStyle(
                color: kTextPrimaryColour,
                fontFamily: kFontFamily,
                fontSize: 18.0,
                fontWeight: kFontWeightSemiBold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: kDarkPrimaryColour,
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.85,
                MediaQuery.of(context).size.height * 0.08,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
