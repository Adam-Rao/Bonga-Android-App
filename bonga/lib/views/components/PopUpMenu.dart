import 'package:flutter/material.dart';

import '../../constants.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<kPopUpMenuValues>(
      onSelected: (kPopUpMenuValues value) {
        if (value == kPopUpMenuValues.Profile) {
          Navigator.pushNamed(context, '/profile');
        } else if (value == kPopUpMenuValues.Settings) {
          null;
        } else if (value == kPopUpMenuValues.Logout) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/', (route) => false);
        }
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<kPopUpMenuValues>>[
        const PopupMenuItem<kPopUpMenuValues>(
          value: kPopUpMenuValues.Profile,
          child: Text('Profile'),
        ),
        const PopupMenuItem<kPopUpMenuValues>(
          value: kPopUpMenuValues.Settings,
          child: Text('Settings'),
        ),
        const PopupMenuItem<kPopUpMenuValues>(
          value: kPopUpMenuValues.Logout,
          child: Text('Logout'),
        ),
      ],
    );
  }
}