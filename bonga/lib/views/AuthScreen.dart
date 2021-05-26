import 'package:bonga/constants.dart';
import 'package:bonga/views/components/MajorButton.dart';
import 'package:bonga/views/components/Text.dart';
import 'package:flutter/material.dart';

import 'components/ItemRow.dart';

class AuthScreen extends StatelessWidget {
  // TODO: Code Horizontal Layout for this screen

  final List<Widget> _appBanner = [
    AppText(
      'Bong',
      kFontWeightSemiBold,
      24.0,
      kTextPrimaryColour,
    ),
    Container(
      height: 23.0,
      width: 24.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/app_icon.png',
          ),
          fit: BoxFit.contain,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: kSizeSetter(context, 'Height', 0.3),
            child: Center(
              child: ItemRow(
                _appBanner,
                MainAxisAlignment.center,
              ),
            ),
          ),
          SizedBox(
            height: kSizeSetter(context, 'Height', 0.1),
          ),
          Container(
            height: kSizeSetter(context, 'Height', 0.35),
            child: Column(
              children: [
                MajorButton(
                  onPress: () {
                    kNormalPush(context, '/registration');
                  },
                  buttonColour: kDarkPrimaryColour,
                  buttonTextColour: kTextPrimaryColour,
                  buttonText: 'REGISTRATION',
                  buttonWidth:
                      kSizeSetter(context, 'Width', kAuthButtonWidthRatio),
                  buttonHeight:
                      kSizeSetter(context, 'Height', kAuthButtonHeightRatio),
                ),
                SizedBox(
                  height: kSizeSetter(context, 'Height', 0.05),
                ),
                MajorButton(
                  onPress: () {
                    kNormalPush(context, '/login');
                  },
                  buttonColour: kLightPrimaryColour,
                  buttonTextColour: kPrimaryTextColour,
                  buttonText: 'LOGIN',
                  buttonWidth:
                      kSizeSetter(context, 'Width', kAuthButtonWidthRatio),
                  buttonHeight:
                      kSizeSetter(context, 'Height', kAuthButtonHeightRatio),
                ),
                SizedBox(
                  height: kSizeSetter(context, 'Height', 0.05),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: null,
                    child: AppText(
                      'Forgot your password?',
                      kFontWeightSemiBold,
                      14.0,
                      kTextPrimaryColour,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
