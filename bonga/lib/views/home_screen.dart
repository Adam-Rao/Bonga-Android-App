import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../constants.dart';
import 'inbox_screen.dart';
import 'components/app_bar.dart';
import 'components/text.dart';
import 'components/popup_menu.dart';
import 'components/text_field.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _searching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        kNormalPush(context, '/login');
      });
    }
  }

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
            : CommonTextField(
                fieldController: _searchController,
                hintText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: _clearSearchBar,
                  color: Colors.grey,
                ),
              ),
      ),
      body: _searching == false
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: InboxScreen(),
            )
          : Search(),
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
