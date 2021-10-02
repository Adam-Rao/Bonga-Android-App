import 'package:bonga/constants.dart';
import 'package:bonga/controllers/mock_data_controller.dart';
import 'package:bonga/models/message_item.dart';
import 'package:bonga/views/components/app_bar.dart';
import 'package:bonga/views/components/chat_screen_user_input.dart';
import 'package:bonga/views/components/indicator.dart';
import 'package:bonga/views/components/message_bubble.dart';
import 'package:bonga/views/components/profile_avatar.dart';
import 'package:bonga/views/components/text.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? _args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      appBar: UniversalAppBar(
        actions: null,
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/home'),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            Center(
              child: Container(
                height: 30.0,
                width: 30.0,
                child: FittedBox(
                  child: AvatarContainer(40.0, false, null, 'Chat Screen'),
                ),
              ),
            ),
            SizedBox(
              width: 30.0,
            ),
            AppText(
              _args != null ? _args['username'] : "Some User",
              kFontWeightSemiBold,
              13.0,
              kTextPrimaryColour,
            ),
            SizedBox(
              width: 10.0,
            ),
            Center(
              child: _args != null
                  ? _args['isOnline'] == true
                      ? Indicator(
                          size: 10.0,
                          unreadMessages: null,
                        )
                      : Container()
                  : Container(),
            ),
          ],
        ),
      ),
      body: ChatScreenBody(),
    );
  }
}

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({Key? key}) : super(key: key);

  @override
  _ChatScreenBodyState createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<List<MessageItem>>(
              stream:
                  Stream.fromFuture(MockDataController.getMessages(context)),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: AppText(
                      '${snapshot.error}',
                      kFontWeightSemiBold,
                      14.0,
                      kTextPrimaryColour,
                    ),
                  );
                } else if (snapshot.hasData) {
                  List<MessageItem> messages = snapshot.data!;

                  return ListView.separated(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment:
                            messages[index].getMessageAuthor != "Some Username"
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: messages[index].getMessageAuthor !=
                                      "Some Username"
                                  ? EdgeInsets.only(
                                      right: kSizeSetter(context, 'Width', 0.3))
                                  : EdgeInsets.only(
                                      left: kSizeSetter(context, 'Width', 0.3)),
                              child: MessageBubble(
                                messages[index].getMessageAuthor !=
                                        "Some Username"
                                    ? false
                                    : true,
                                messages[index].getMessageBody,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: Colors.transparent,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
        UserInputComponent(),
      ],
    );
  }
}
