import 'package:bonga/views/components/text_field.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'text.dart';

class EditDetail extends StatelessWidget {
  const EditDetail(
      {Key? key,
      required TextEditingController detailController,
      required String hintText,
      Function()? detailHandler})
      : _detailController = detailController,
        _detailHandler = detailHandler,
        _hintText = hintText,
        super(key: key);

  final TextEditingController _detailController;
  final String _hintText;
  final Function()? _detailHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: CommonTextField(
            fieldController: _detailController,
            hintText: _hintText,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: AppText(
                'CANCEL',
                kFontWeightSemiBold,
                14.0,
                kTextPrimaryColour,
              ),
            ),
            TextButton(
              onPressed: _detailHandler,
              child: AppText(
                'OK',
                kFontWeightSemiBold,
                14.0,
                kTextPrimaryColour,
              ),
            ),
          ],
        )
      ],
    );
  }
}
