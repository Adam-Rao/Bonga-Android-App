import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'views/components/item_row.dart';
import 'views/components/text.dart';

// Colours
Color kDarkPrimaryColour = Color(0xFF455A64);
Color kDefaultPrimaryColour = Color(0xFF607D88);
Color kLightPrimaryColour = Color(0xFFCFD8DC);
Color kTextPrimaryColour = Color(0xFFFFFFFF);
Color kAccentColour = Color(0xFF607D88);
Color kPrimaryTextColour = Color(0xFF212121);
Color kPrimarySecondaryTextColour = Color(0xFF757575);
Color kPrimaryDividerColour = Color(0xFFBDBDBD);

// Font
String kFontFamily = 'Poppins';
double kHintTextSize = 12.0;

FontWeight kFontWeightRegular = FontWeight.w400;
FontWeight kFontWeightSemiBold = FontWeight.w600;
FontWeight kFontWeightBold = FontWeight.w700;

// Auth Validation Regex
RegExp kEmailRegExPattern = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

RegExp kPasswordRegExPattern =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

// Device size
Function kGetDeviceHeight = (BuildContext context) {
  return MediaQuery.of(context).size.height;
};

Function kGetDeviceWidth = (BuildContext context) {
  return MediaQuery.of(context).size.width;
};

// Popup menu value
enum kPopUpMenuValues { Profile, Settings, Logout }

// Navigator functions

Function kNormalPush = (BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
};

double kAuthButtonHeightRatio = 0.08;
double kAuthButtonWidthRatio = 0.85;

Function kSizeSetter = (BuildContext context, String sizeType, double ratio) {
  switch (sizeType) {
    case 'Height':
      return kGetDeviceHeight(context) * ratio;
    case 'Width':
      return kGetDeviceWidth(context) * ratio;
    default:
      break;
  }
};

//Validators
String kEmptyEmailValidatorError = 'Please enter an email address';
String kInvalidEmailValidatorError = 'Please enter a valid email address';

String kEmptyPasswordValidatorError = 'Please enter a password';
String kInvalidPasswordValidatorError =
    'Password must have at least one: digit, upper case letter, lower case letter';

List<ItemRow> kAccountSettingsList = [
  ItemRow(
    [
      Icon(
        Icons.lock,
        color: Colors.white,
        size: 30.0,
      ),
      SizedBox(
        width: 20.0,
      ),
      AppText(
        'Change Password',
        kFontWeightSemiBold,
        14.0,
        kTextPrimaryColour,
      ),
    ],
    MainAxisAlignment.start,
  ),
  ItemRow(
    [
      Icon(
        Icons.delete,
        color: Colors.white,
        size: 30.0,
      ),
      SizedBox(
        width: 20.0,
      ),
      AppText(
        'Delete Your Account',
        kFontWeightSemiBold,
        14.0,
        kTextPrimaryColour,
      ),
    ],
    MainAxisAlignment.start,
  ),
  ItemRow(
    [
      Icon(
        Icons.info,
        color: Colors.white,
        size: 30.0,
      ),
      SizedBox(
        width: 20.0,
      ),
      AppText(
        'General Info & Privacy Policy',
        kFontWeightSemiBold,
        14.0,
        kTextPrimaryColour,
      ),
    ],
    MainAxisAlignment.start,
  ),
  ItemRow(
    [
      Icon(
        Icons.shield,
        color: Colors.white,
        size: 30.0,
      ),
      SizedBox(
        width: 20.0,
      ),
      AppText(
        'Privacy Settings',
        kFontWeightSemiBold,
        14.0,
        kTextPrimaryColour,
      ),
    ],
    MainAxisAlignment.start,
  ),
];

Function kShowBottomSheet =
    (BuildContext context, double height, Widget content) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: height,
            color: kDarkPrimaryColour,
            child: content,
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
};

String kDeleteAccountInformation =
    'This operation is irreversible.\nAll data associated with this account will be deleted.';