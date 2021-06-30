import 'package:bonga/constants.dart';
import 'package:bonga/views/components/app_bar.dart';
import 'package:bonga/views/components/popup_menu.dart';
import 'package:bonga/views/components/text.dart';
import 'package:flutter/material.dart';

import 'components/edit_detail.dart';
import 'components/item_row.dart';
import 'components/major_button.dart';
import 'components/profile_avatar.dart';

class ProfileScreen extends StatelessWidget {
  final List<Widget> _usernameRowItems = [
    Icon(
      Icons.person,
      color: Colors.white,
      size: 50.0,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Username',
          kFontWeightSemiBold,
          13.0,
          kTextPrimaryColour,
        ),
        SizedBox(height: 2.0),
        AppText(
          'Placeholder Username',
          kFontWeightSemiBold,
          11.0,
          kTextPrimaryColour,
        ),
      ],
    ),
    IconButton(
      onPressed: null,
      icon: Icon(
        Icons.edit,
        color: Colors.white,
        size: 30.0,
      ),
    ),
  ];

  final List<Widget> _aboutRowItems = [
    Icon(
      Icons.info,
      color: Colors.white,
      size: 50.0,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'About',
          kFontWeightSemiBold,
          13.0,
          kTextPrimaryColour,
        ),
        SizedBox(height: 2.0),
        AppText(
          'Something pretentious',
          kFontWeightSemiBold,
          11.0,
          kTextPrimaryColour,
        ),
      ],
    ),
    IconButton(
      onPressed: null,
      icon: Icon(
        Icons.edit,
        color: Colors.white,
        size: 30.0,
      ),
    ),
  ];

  final List<Widget> _emailAddressRowItems = [
    Icon(
      Icons.email,
      color: Colors.white,
      size: 50.0,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Email Address',
          kFontWeightSemiBold,
          13.0,
          kTextPrimaryColour,
        ),
        SizedBox(height: 2.0),
        AppText(
          'someemail@example.com',
          kFontWeightSemiBold,
          11.0,
          kTextPrimaryColour,
        ),
      ],
    ),
    IconButton(
      onPressed: null,
      icon: Icon(
        Icons.edit,
        color: Colors.white,
        size: 30.0,
      ),
    ),
  ];

  final TextEditingController _editEmailController = TextEditingController(
    text: 'someemail@example.com',
  );

  final TextEditingController _editAboutController = TextEditingController(
    text: 'Something pretentious',
  );

  final TextEditingController _editUsernameController = TextEditingController(
    text: 'Placeholder Username',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      appBar: UniversalAppBar(
        actions: [
          PopUpMenu('ProfileScreen'),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: AppText(
          'Profile',
          kFontWeightSemiBold,
          16.0,
          kTextPrimaryColour,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: AvatarContainer(
            kSizeSetter(context, 'Width', 0.15),
            false,
            null,
            'Profile Screen'
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 10.0,
            left: kSizeSetter(context, 'Width', 0.2),
            right: kSizeSetter(context, 'Width', 0.2),
          ),
          child: MajorButton(
            onPress: null,
            buttonColour: kDarkPrimaryColour,
            buttonTextColour: kTextPrimaryColour,
            buttonText: 'SET PROFILE AVATAR',
            buttonWidth: kSizeSetter(context, 'Width', 0.6),
            buttonHeight: kSizeSetter(context, 'Height', 0.06),
          ),
        ),
        Divider(
          thickness: 2.0,
          color: kPrimaryDividerColour,
          indent: kSizeSetter(context, 'Width', 0.1),
          endIndent: kSizeSetter(context, 'Width', 0.1),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ItemRow(
                  _usernameRowItems,
                  MainAxisAlignment.spaceEvenly,
                ),
              ),
              onTap: () => kShowBottomSheet(
                context,
                kSizeSetter(context, 'Height', 0.3),
                EditDetail(
                  detailController: _editUsernameController,
                  hintText: '',
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ItemRow(
                  _aboutRowItems,
                  MainAxisAlignment.spaceEvenly,
                ),
              ),
              onTap: () => kShowBottomSheet(
                context,
                kSizeSetter(context, 'Height', 0.3),
                EditDetail(
                  detailController: _editAboutController,
                  hintText: '',
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ItemRow(
                  _emailAddressRowItems,
                  MainAxisAlignment.spaceEvenly,
                ),
              ),
              onTap: () => kShowBottomSheet(
                context,
                kSizeSetter(context, 'Height', 0.3),
                EditDetail(
                  detailController: _editEmailController,
                  hintText: '',
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ]),
    );
  }
}
