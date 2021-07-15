import 'package:bonga/constants.dart';
import 'package:bonga/views/components/text.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this._userMessageOwner, this._message);

  final bool _userMessageOwner;
  final String _message;

  final double _borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: _userMessageOwner == true
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _userMessageOwner == true
                ? kDarkPrimaryColour
                : kLightPrimaryColour,
            borderRadius: _userMessageOwner == true
                ? BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    topRight: Radius.circular(_borderRadius),
                    bottomLeft: Radius.circular(_borderRadius),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(_borderRadius),
                    bottomLeft: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppText(
              _message,
              kFontWeightRegular,
              14.0,
              _userMessageOwner == true
                  ? kTextPrimaryColour
                  : kPrimaryTextColour,
            ),
          ),
        ),
      ],
    );
  }
}
