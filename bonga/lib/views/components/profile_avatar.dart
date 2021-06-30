import 'package:flutter/material.dart';

import '../../constants.dart';

class AvatarContainer extends StatelessWidget {
  final double _radius;
  final bool _isImage;
  final String? _imgUrl;
  final String _screenName;

  const AvatarContainer(
      this._radius, this._isImage, this._imgUrl, this._screenName);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: _isImage == false
          ? _screenName != 'Chat Screen'
              ? kDarkPrimaryColour
              : kDefaultPrimaryColour
          : Colors.transparent,
      child: _isImage == false
          ? Icon(
              Icons.person,
              color: kLightPrimaryColour,
              size: 50.0,
            )
          : null,
      radius: _radius,
      foregroundImage: _isImage == false ? null : NetworkImage(_imgUrl!),
    );
  }
}
