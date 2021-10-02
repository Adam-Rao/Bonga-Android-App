import 'package:bonga/views/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../constants.dart';
import 'inbox_screen.dart';
import 'components/app_bar.dart';
import 'components/text.dart';
import 'components/popup_menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _searching = false;

  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      });
    }
  }

  void _searchStateController() {
    setState(() {
      _searching = !_searching;
    });
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
        leading: _searching == false
            ? Container()
            : IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
        title: _searching == false
            ? AppText(
                'Inbox',
                kFontWeightSemiBold,
                16.0,
                kTextPrimaryColour,
              )
            : AppText(
                'Search',
                kFontWeightSemiBold,
                16.0,
                kTextPrimaryColour,
              ),
      ),
      body: _searching == false
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: InboxScreen(),
            )
          : SearchScreen(),
    );
  }
}
