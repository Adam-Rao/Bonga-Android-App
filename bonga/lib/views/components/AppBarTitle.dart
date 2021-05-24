import 'package:flutter/material.dart';

import '../../constants.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  const AppBarTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Inbox',
      style: TextStyle(
        fontFamily: kFontFamily,
        fontWeight: kFontWeightSemiBold,
        fontSize: 16.0,
      ),
    );
  }
}