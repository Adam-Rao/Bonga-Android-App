import 'package:bonga/constants.dart';
import 'package:bonga/views/components/app_bar.dart';
import 'package:bonga/views/components/popup_menu.dart';
import 'package:bonga/views/components/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'components/edit_detail.dart';
import 'components/item_row.dart';
import 'components/major_button.dart';
import 'components/profile_avatar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final List<Widget> _emailAddressRowItems = [
    SizedBox(
      width: 0.05,
    ),
    Icon(
      Icons.email,
      color: Colors.white,
      size: 50.0,
    ),
    SizedBox(
      width: 0.05,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Email Address',
          kFontWeightSemiBold,
          13.0,
          kTextPrimaryColour,
        ),
        SizedBox(height: 2.0),
        AppText(
          FirebaseAuth.instance.currentUser!.email!,
          kFontWeightSemiBold,
          11.0,
          kTextPrimaryColour,
        ),
      ],
    ),
  ];

  final List<Widget> _emailAddressRowItemsLandScape = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        Icons.email,
        color: Colors.white,
        size: 50.0,
      ),
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Email Address',
          kFontWeightSemiBold,
          13.0,
          kTextPrimaryColour,
        ),
        SizedBox(height: 2.0),
        AppText(
          FirebaseAuth.instance.currentUser!.email!,
          kFontWeightSemiBold,
          11.0,
          kTextPrimaryColour,
        ),
      ],
    ),
    IconButton(
      onPressed: null,
      icon: Icon(
        Icons.edit,
        color: Colors.white,
        size: 30.0,
      ),
    ),
  ];

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final _editAboutController = TextEditingController();
  final _editUsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      appBar: UniversalAppBar(
        actions: [
          PopUpMenu('ProfileScreen'),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: AppText(
          'Profile',
          kFontWeightSemiBold,
          16.0,
          kTextPrimaryColour,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(msg: 'Error loading data');
          } else if (snapshot.hasData) {
            Map<String, dynamic> userDetails =
                snapshot.data as Map<String, dynamic>;

            _editUsernameController.text = userDetails['username'];
            _editAboutController.text = userDetails['about'];

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: AvatarContainer(
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? kSizeSetter(context, 'Width', 0.15)
                          : kSizeSetter(context, 'Width', 0.1),
                      false,
                      null,
                      'Profile Screen',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 10.0,
                      left: kSizeSetter(context, 'Width', 0.2),
                      right: kSizeSetter(context, 'Width', 0.2),
                    ),
                    child: MajorButton(
                      onPress: null,
                      buttonColour: kDarkPrimaryColour,
                      buttonTextColour: kTextPrimaryColour,
                      buttonText: 'SET PROFILE AVATAR',
                      buttonWidth: kSizeSetter(context, 'Width', 0.6),
                      buttonHeight: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? kSizeSetter(context, 'Height', 0.06)
                          : kSizeSetter(context, 'Height', 0.15),
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: kPrimaryDividerColour,
                    indent: kSizeSetter(context, 'Width', 0.1),
                    endIndent: kSizeSetter(context, 'Width', 0.1),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ItemRow(
                            [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    'Username',
                                    kFontWeightSemiBold,
                                    13.0,
                                    kTextPrimaryColour,
                                  ),
                                  SizedBox(height: 2.0),
                                  AppText(
                                    userDetails['username'],
                                    kFontWeightSemiBold,
                                    11.0,
                                    kTextPrimaryColour,
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ],
                            MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                        onTap: () => kShowBottomSheet(
                          context,
                          MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? kSizeSetter(context, 'Height', 0.3)
                              : kSizeSetter(context, 'Height', 0.5),
                          EditDetail(
                            detailController: _editUsernameController,
                            hintText: '',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ItemRow(
                            [
                              Icon(
                                Icons.info,
                                color: Colors.white,
                                size: 50.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    'About',
                                    kFontWeightSemiBold,
                                    13.0,
                                    kTextPrimaryColour,
                                  ),
                                  SizedBox(height: 2.0),
                                  AppText(
                                    userDetails['about'],
                                    kFontWeightSemiBold,
                                    11.0,
                                    kTextPrimaryColour,
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ],
                            MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                        onTap: () => kShowBottomSheet(
                          context,
                          MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? kSizeSetter(context, 'Height', 0.3)
                              : kSizeSetter(context, 'Height', 0.5),
                          EditDetail(
                            detailController: _editAboutController,
                            hintText: '',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ItemRow(
                          MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? _emailAddressRowItems
                              : _emailAddressRowItemsLandScape,
                          MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
