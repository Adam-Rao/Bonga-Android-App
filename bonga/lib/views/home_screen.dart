import 'package:bonga/views/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../constants.dart';
import 'components/app_bar.dart';
import 'components/text.dart';
import 'components/popup_menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      appBar: UniversalAppBar(
        actions: [
          PopUpMenu('HomeScreen'),
        ],
        title: AppText(
          'Bonga',
          kFontWeightSemiBold,
          16.0,
          kTextPrimaryColour,
        ),
      ),
      body: SearchScreen(),
    );
  }
}
