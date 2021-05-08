import 'package:bonga/constants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
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
  bool _firstPasswordVisibilityValue = true;
  bool _secondPasswordVisibilityValue = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registrationFormKey,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
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
              hintText: 'Enter your email address',
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
              } else if (!KEmailRegExPattern.hasMatch(value)) {
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
              hintText: 'Password must be 8 characters long.',
              hintStyle: TextStyle(
                fontFamily: kFontFamily,
                fontSize: kHintTextSize,
                fontWeight: kFontWeightSemiBold,
              ),
              suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_rounded),
                  onPressed: () {
                    setState(() {
                      _firstPasswordVisibilityValue =
                          !_firstPasswordVisibilityValue;
                    });
                  }),
            ),
            obscureText: _firstPasswordVisibilityValue,
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
          TextFormField(
            controller: _confirmPasswordTextFieldController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              fillColor: kTextPrimaryColour,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kDefaultPrimaryColour,
                ),
              ),
              hintText: 'Re-enter your password',
              hintStyle: TextStyle(
                fontFamily: kFontFamily,
                fontSize: kHintTextSize,
                fontWeight: kFontWeightSemiBold,
              ),
              suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_rounded),
                  onPressed: () {
                    setState(() {
                      _secondPasswordVisibilityValue =
                          !_secondPasswordVisibilityValue;
                    });
                  }),
            ),
            obscureText: _secondPasswordVisibilityValue,
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
                return 'Password must be at least 8 characters long and must have at least one: digit, upper case letter, lower case letter';
              }
              return null;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          ElevatedButton(
            onPressed: null,
            child: Text(
              'REGISTER',
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
