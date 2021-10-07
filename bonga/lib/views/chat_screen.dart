import 'package:bonga/constants.dart';
import 'package:bonga/views/components/app_bar.dart';
import 'package:bonga/views/components/chat_screen_user_input.dart';
import 'package:bonga/views/components/indicator.dart';
import 'package:bonga/views/components/message_bubble.dart';
import 'package:bonga/views/components/profile_avatar.dart';
import 'package:bonga/views/components/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                height: 45.0,
                width: 45.0,
                child: FittedBox(
                  child: _args?['profile_picture'] == "" ||
                          _args?['profile_picture_visible'] == false
                      ? AvatarContainer(50.0, false, null, 'Chat Screen')
                      : AvatarContainer(
                          50.0,
                          true,
                          _args?['profile_picture'],
                          'Chat Screen',
                        ),
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
      body: ChatScreenBody(recepientID: _args?['userID']),
    );
  }
}

class ChatScreenBody extends StatefulWidget {
  final String? recepientID;
  const ChatScreenBody({Key? key, this.recepientID}) : super(key: key);

  @override
  _ChatScreenBodyState createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  String _userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.recepientID == null
                ? Center(
                    //prevents crash that occurs when recepient ID isn't initialized yet
                    child: CircularProgressIndicator(),
                  )
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('rooms/${widget.recepientID}/messages')
                        .where('author_id', isEqualTo: _userID)
                        .where('receipient_id', isEqualTo: widget.recepientID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: AppText(
                            'Something went wrong',
                            kFontWeightSemiBold,
                            14.0,
                            kTextPrimaryColour,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.separated(
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> _message =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return Row(
                              mainAxisAlignment:
                                  _message['author_id'] != _userID
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: _message['author_id'] != _userID
                                        ? EdgeInsets.only(
                                            right: kSizeSetter(
                                                context, 'Width', 0.3))
                                        : EdgeInsets.only(
                                            left: kSizeSetter(
                                                context, 'Width', 0.3)),
                                    child: MessageBubble(
                                      _message['author_id'] != _userID
                                          ? false
                                          : true,
                                      _message['message_content'],
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
                      if (snapshot.data!.docs.length == 0) {
                        return Center(
                          child: AppText(
                            'No chats yet',
                            kFontWeightSemiBold,
                            12.0,
                            kTextPrimaryColour,
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
          ),
        ),
        UserInputComponent(
          authorID: _userID,
          receipientID: widget.recepientID,
        ),
      ],
    );
  }
}
