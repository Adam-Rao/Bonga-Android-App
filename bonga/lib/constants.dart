import 'package:bonga/models/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'views/components/indicator.dart';
import 'views/components/item_row.dart';
import 'views/components/profile_avatar.dart';
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

// List of Dummy messages. Delete After Development
List<MessageItem> kDevMessageItems = [
  MessageItem(1, "Munyau", "Niaje motherfucker?", ''),
  MessageItem(1, "Atieno", "Ilikuwa tupatane wapi?", ''),
  MessageItem(10, "Mtunguyaz", "Buda, ushafanya cat?", ''),
  MessageItem(
      0, "Felo", "Buda iyo anime ilikuwa ufala. Lip syncing was way off.", ''),
  MessageItem(
      0, "Esther", "Unaeza tumia OpenSSL for generating your keys.", ''),
  MessageItem(
      3,
      "Wendy",
      "Urm, yeah. If the conversation is leading to that direction, I'm not looking for that right now.",
      ''),
  MessageItem(
      8, "Robinson", "Buda, mtu akitaka kuenda Karura anapanda mat gani?", ''),
  MessageItem(2, "Okundi", "Msee. Unajua place naeza pata invincible?", ''),
  MessageItem(0, "Bazenga", "Niaje? Utakuwa ma-area wikendi?", ''),
  MessageItem(
      0,
      "Dee",
      "You stir the mixture until it becomes thick. Add some sugar and stir for 5 more minutes",
      ''),
  MessageItem(0, "Siz", "Karibu osiepa", ''),
  MessageItem(0, "Azariah", "Nilipata zile tools za kufungua nayo pipe", ''),
  MessageItem(
      1, "Allan", "Ukidai booti fika ivi kwa kina Mel. Kuna mzinga.", ''),
  MessageItem(
      5,
      "Ochola",
      "Bro. If you have the cash, invest in Mumias. It's about 5 shillings a share.",
      ''),
];

List<Widget> kGenerateMessages(BuildContext context) {
  List<Widget> messages = [];
  for (var messageItem in kDevMessageItems) {
    List<Widget> message = [
      AvatarContainer(
        kSizeSetter(context, 'Width', 0.09),
        false,
        messageItem.getMessageAuthorImageURL,
      ),
      SizedBox(
        width: kSizeSetter(context, 'Width', 0.1),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              messageItem.getMessageAuthor,
              kFontWeightBold,
              13.0,
              kTextPrimaryColour,
            ),
            AppText(
              // '${messageItem.getMessageBody.substring(0, 10)}...',
              messageItem.getMessageBody.length <= 20
                  ? '${messageItem.getMessageBody}'
                  : '${messageItem.getMessageBody.substring(0, 21)}...',
              kFontWeightRegular,
              13.0,
              kTextPrimaryColour,
            ),
          ],
        ),
      ),
      SizedBox(
        width: kSizeSetter(context, 'Width', 0.05),
      ),
      messageItem.getUnreadMessages != 0
          ? Indicator(
              size: 24.0,
              unreadMessages: messageItem.getUnreadMessages,
            )
          : Container() // Container prevents app from crashing,
    ];

    messages.add(ItemRow(message, MainAxisAlignment.spaceBetween));
  }

  return messages;
}
