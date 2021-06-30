import 'package:bonga/constants.dart';
import 'package:bonga/views/components/app_bar.dart';
import 'package:bonga/views/components/chat_screen_user_input.dart';
import 'package:bonga/views/components/indicator.dart';
import 'package:bonga/views/components/profile_avatar.dart';
import 'package:bonga/views/components/text.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: AvatarContainer(
                    20.0,
                    false,
                    null,
                  ),
                ),
              ),
            ),
            SizedBox(width: 30.0,),
            AppText(
              'Some Other User',
              kFontWeightSemiBold,
              13.0,
              kTextPrimaryColour,
            ),
            SizedBox(width: 10.0,),
            Center(
              child: Indicator(
                size: 10.0,
                unreadMessages: null,
              ),
            ),
          ],
        ),
      ),
      body: ChatScreenBody(),
    );
  }
}

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container();
            },
            itemCount: 15,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          ),
        ),
        UserInputComponent(),
      ],
    );
  }
}
