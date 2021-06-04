import 'package:bonga/constants.dart';
import 'package:bonga/views/components/ItemRow.dart';
import 'package:bonga/views/components/ProfileAvatar.dart';
import 'package:flutter/material.dart';

import 'components/AppBar.dart';
import 'components/PopUpMenu.dart';
import 'components/Text.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      appBar: UniversalAppBar(
        actions: [
          PopUpMenu('SettingsScreen'),
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
          'Settings',
          kFontWeightSemiBold,
          16.0,
          kTextPrimaryColour,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: kSizeSetter(context, 'Height', 0.2),
            child: ItemRow(
              [
                AvatarContainer(
                  kSizeSetter(context, 'Width', 0.1),
                  false,
                  '',
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      'Username',
                      kFontWeightSemiBold,
                      16.0,
                      kTextPrimaryColour,
                    ),
                    SizedBox(height: 2.0),
                    AppText(
                      'Placeholder Username',
                      kFontWeightSemiBold,
                      14.0,
                      kTextPrimaryColour,
                    ),
                  ],
                ),
              ],
              MainAxisAlignment.center,
            ),
          ),
          Divider(
            thickness: 2.0,
            color: kPrimaryDividerColour,
            indent: kSizeSetter(context, 'Width', 0.1),
            endIndent: kSizeSetter(context, 'Width', 0.1),
          ),
          ListView.separated(
            padding: EdgeInsets.all(20.0),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  null;
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: kAccountSettingsList[index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              color: Colors.transparent,
            ),
            itemCount: kAccountSettingsList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          ),
        ],
      ),
    );
  }
}
