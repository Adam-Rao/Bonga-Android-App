import 'package:flutter/material.dart';

import '../../constants.dart';

class UserInputComponent extends StatefulWidget {
  const UserInputComponent({Key? key}) : super(key: key);

  @override
  _UserInputComponentState createState() => _UserInputComponentState();
}

class _UserInputComponentState extends State<UserInputComponent> {
  TextEditingController _userInputController = TextEditingController();

  @override
  void dispose() {
    _userInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDarkPrimaryColour,
      padding: EdgeInsets.all(10.0),
      width: kSizeSetter(context, 'Width', 1.0),
      height: kSizeSetter(context, 'Height', 0.1),
      child: Row(
        children: [
          Expanded(
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
                fillColor: Colors.white,
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
          Container(
            height: 50.0,
            width: 50.0,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: kLightPrimaryColour,
                onPressed: null,
                child: Center(
                  child: Icon(
                    Icons.send,
                    color: Colors.black,
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