import 'package:bonga/constants.dart';
import 'package:bonga/controllers/mock_data_controller.dart';
import 'package:bonga/models/message_item.dart';
import 'package:bonga/views/components/item_row.dart';
import 'package:bonga/views/components/text.dart';
import 'package:flutter/material.dart';

import 'components/indicator.dart';
import 'components/profile_avatar.dart';

class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MessageItem>>(
      future: MockDataController.getMessages(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageItem> inboxMessages = snapshot.data!;

          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  kNormalPush(context, '/chat');
                },
                child: ItemRow(
                  [
                    AvatarContainer(
                        kSizeSetter(context, 'Width', 0.09),
                        false,
                        inboxMessages[index].getMessageAuthorImageURL,
                        'Home Screen'),
                    SizedBox(
                      width: kSizeSetter(context, 'Width', 0.1),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            inboxMessages[index].getMessageAuthor,
                            kFontWeightBold,
                            13.0,
                            kTextPrimaryColour,
                          ),
                          AppText(
                            // '${inboxMessages[index].getMessageBody.substring(0, 10)}...',
                            inboxMessages[index].getMessageBody.length <= 20
                                ? '${inboxMessages[index].getMessageBody}'
                                : '${inboxMessages[index].getMessageBody.substring(0, 21)}...',
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
                    inboxMessages[index].getUnreadMessages != 0
                        ? Indicator(
                            size: 24.0,
                            unreadMessages:
                                inboxMessages[index].getUnreadMessages,
                          )
                        : Container() // Container prevents app from crashing,
                  ],
                  MainAxisAlignment.spaceBetween,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 2.0,
              color: kPrimaryDividerColour,
              indent: kSizeSetter(context, 'Width', 0.15),
              endIndent: kSizeSetter(context, 'Width', 0.02),
            ),
            itemCount: inboxMessages.length,
            padding: EdgeInsets.all(10.0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: AppText(
              '${snapshot.error}',
              kFontWeightSemiBold,
              14.0,
              kTextPrimaryColour,
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
