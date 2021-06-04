import 'package:flutter/material.dart';

import '../constants.dart';
import 'components/AppBar.dart';
import 'components/Text.dart';
import 'components/PopUpMenu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _searching = false;
  TextEditingController _searchController = TextEditingController();

  void _searchStateController() {
    setState(() {
      _searching = !_searching;
    });
  }

  void _clearSearchBar() {
    _searchController.clear();
    _searchStateController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      appBar: UniversalAppBar(
        actions: [
          _searching == false
              ? IconButton(
                  onPressed: _searchStateController,
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              : Container(), //Prevents app from crashing
          PopUpMenu('HomeScreen'),
        ],
        title: _searching == false
            ? AppText(
                'Inbox',
                kFontWeightSemiBold,
                16.0,
                kTextPrimaryColour,
              )
            : TextField(
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
                    onPressed: _clearSearchBar,
                  ),
                ),
                style: TextStyle(
                  color: kTextPrimaryColour,
                  fontFamily: kFontFamily,
                  fontSize: 16.0,
                  fontWeight: kFontWeightRegular,
                ),
              ),
      ),
      body: _searching == false ? Inbox() : Search(),
    );
  }
}

class Inbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Inbox Empty'),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No search results'),
    );
  }
}
