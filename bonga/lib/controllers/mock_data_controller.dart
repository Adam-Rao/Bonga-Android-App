import 'dart:convert';

import 'package:bonga/models/message_item.dart';
import 'package:flutter/cupertino.dart';

class MockDataController {
  static Future<List<MessageItem>> getMessages(BuildContext context) async {
    final mockData = await DefaultAssetBundle.of(context)
        .loadString('assets/MOCK_DATA.json');

    final data = jsonDecode(mockData);

    return data.map<MessageItem>(MessageItem.parseJson).toList();
  }
}
