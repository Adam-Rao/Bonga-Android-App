import 'package:flutter/material.dart';

import '../constants.dart';
import 'components/AppBarTitle.dart';
import 'components/PopUpMenu.dart';
import 'components/SearchField.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _searching = false;
  TextEditingController _searchController = TextEditingController();

  void _searchFieldController() {
    setState(() {
      _searching != _searching;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      appBar: AppBar(
        actions: [
          _searching == false
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _searching = !_searching;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              : Container(), //Prevents app from crashing
          PopUpMenu(),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: kDarkPrimaryColour,
        centerTitle: true,
        title: _searching == false
            ? AppBarTitle('Inbox')
            : SearchTextField(
                searchController: _searchController,
                searchFieldController: _searchFieldController,
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
