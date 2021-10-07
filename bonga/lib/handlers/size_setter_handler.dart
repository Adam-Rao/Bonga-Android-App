import 'package:flutter/material.dart';

import '../constants.dart';

Function sizeSetter = (BuildContext context, String sizeType, double ratio) {
  switch (sizeType) {
    case 'Height':
      return kGetDeviceHeight(context) * ratio;
    case 'Width':
      return kGetDeviceWidth(context) * ratio;
    default:
      break;
  }
};