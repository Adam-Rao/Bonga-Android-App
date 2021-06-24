import 'package:bonga/constants.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            print("Hello");
          },
          child: kGenerateMessages(context)[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
          thickness: 2.0,
          color: kPrimaryDividerColour,
          indent: kSizeSetter(context, 'Width', 0.15),
          endIndent: kSizeSetter(context, 'Width', 0.02),
        ),
      itemCount: kGenerateMessages(context).length,
      padding: EdgeInsets.all(10.0),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
    );
  }
}
