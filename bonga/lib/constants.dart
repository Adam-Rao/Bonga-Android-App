import 'package:flutter/painting.dart';

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
