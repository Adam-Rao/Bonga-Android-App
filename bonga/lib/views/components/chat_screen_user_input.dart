import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class UserInputComponent extends StatefulWidget {
  final String? authorID;
  final String? receipientID;
  const UserInputComponent({Key? key, this.authorID, this.receipientID})
      : super(key: key);

  @override
  _UserInputComponentState createState() => _UserInputComponentState();
}

class _UserInputComponentState extends State<UserInputComponent> {
  TextEditingController _userInputController = TextEditingController();

  void _sendMessage(String messageContent) async {
    await FirebaseFirestore.instance
        .collection('rooms/${widget.receipientID}/messages')
        .add({
      'author_id': widget.authorID,
      'message_content': messageContent,
      'receipient_id': widget.receipientID,
    });
  }

  @override
  void dispose() {
    _userInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDarkPrimaryColour,
      width: kSizeSetter(context, 'Width', 1.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _userInputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kDefaultPrimaryColour,
                    ),
                  ),
                  fillColor: kTextPrimaryColour,
                  filled: true,
                  hintText: 'Type message...',
                  hintStyle: TextStyle(
                    fontSize: kHintTextSize,
                    fontFamily: kFontFamily,
                    fontWeight: kFontWeightRegular,
                    color: Color(0X40000000),
                  ),
                  prefixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.emoji_emotions_rounded,
                      color: Color(0X40000000),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add,
                      color: Color(0X40000000),
                    ),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                  color: kPrimaryTextColour,
                  fontFamily: kFontFamily,
                  fontSize: 16.0,
                  fontWeight: kFontWeightRegular,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 50.0,
              width: 50.0,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: kLightPrimaryColour,
                  onPressed: () {
                    _sendMessage(_userInputController.text);
                  },
                  child: Center(
                    child: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
