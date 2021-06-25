import 'package:bonga/constants.dart';
import 'package:bonga/views/components/Text.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  /*
  Indicates whether a user is online or not.
  Also indicates number of unread messages.
  */
  const Indicator({Key? key, required double size, int? unreadMessages})
      : _size = size,
        _unreadMessages = unreadMessages,
        super(key: key);

  final double _size;
  final int? _unreadMessages;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size,
      width: _size,
      child: Material(
        color: kLightPrimaryColour,
        type: MaterialType.circle,
        child: _unreadMessages == 0 || _unreadMessages == null
            ? null
            : Center(
              child: AppText(
                  _unreadMessages.toString(),
                  kFontWeightSemiBold,
                  9.0,
                  kPrimaryTextColour,
                ),
            ),
      ),
    );
  }
}
