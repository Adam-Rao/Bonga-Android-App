import 'package:flutter/material.dart';

import '../../constants.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {Key key,
      @required TextEditingController searchController,
      @required Function searchFieldController})
      : _searchController = searchController,
        _searchFieldController = searchFieldController,
        super(key: key);

  final TextEditingController _searchController;
  final Function _searchFieldController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(
          fontFamily: kFontFamily,
          fontSize: kHintTextSize,
          fontWeight: kFontWeightSemiBold,
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            _searchController.clear();
            _searchFieldController;
          },
        ),
      ),
      style: TextStyle(
        color: kTextPrimaryColour,
        fontFamily: kFontFamily,
        fontSize: 16.0,
        fontWeight: kFontWeightRegular,
      ),
    );
  }
}