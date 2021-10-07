import 'package:bonga/constants.dart';
import 'package:bonga/controllers/account_management.dart';
import 'package:bonga/handlers/size_setter_handler.dart';
import 'package:bonga/handlers/upload_image_handler.dart';
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

class ProfileScreen extends StatelessWidget {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final _editAboutController = TextEditingController();
  final _editUsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? _args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
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
      body: _args == null
          ? UserProfileScreen(
              userId: userId,
              editUsernameController: _editUsernameController,
              editAboutController: _editAboutController,
            )
          : SearchedUserProfileScreen(args: _args),
    );
  }
}

class SearchedUserProfileScreen extends StatelessWidget {
  const SearchedUserProfileScreen({
    Key? key,
    required Map<String, dynamic>? args,
  }) : _args = args, super(key: key);

  final Map<String, dynamic>? _args;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: _args!['profile_picture'] == '' ||
                      _args!['profile_picture_visible'] == false
                  ? AvatarContainer(
                      MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? sizeSetter(context, 'Width', 0.15)
                          : sizeSetter(context, 'Width', 0.1),
                      false,
                      null,
                      'Profile Screen',
                    )
                  : AvatarContainer(
                      MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? sizeSetter(context, 'Width', 0.15)
                          : sizeSetter(context, 'Width', 0.1),
                      true,
                      _args!['profile_picture'],
                      'Profile Screen',
                    ),
            ),
            Divider(
              thickness: 2.0,
              color: kPrimaryDividerColour,
              indent: sizeSetter(context, 'Width', 0.1),
              endIndent: sizeSetter(context, 'Width', 0.1),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ItemRow(
                    [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                            'Username',
                            kFontWeightSemiBold,
                            16.0,
                            kTextPrimaryColour,
                          ),
                          SizedBox(height: 2.0),
                          AppText(
                            _args!['username'],
                            kFontWeightSemiBold,
                            14.0,
                            kTextPrimaryColour,
                          ),
                        ],
                      ),
                    ],
                    MainAxisAlignment.center,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _args!['about_visible'] == true
                      ? ItemRow(
                          [
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              children: [
                                AppText(
                                  'About',
                                  kFontWeightSemiBold,
                                  16.0,
                                  kTextPrimaryColour,
                                ),
                                SizedBox(height: 2.0),
                                AppText(
                                  _args!['about'],
                                  kFontWeightSemiBold,
                                  14.0,
                                  kTextPrimaryColour,
                                ),
                              ],
                            ),
                          ],
                          MainAxisAlignment.center,
                        )
                      : null,
                ),
              ],
            ),
          ],
        ),
      );
  }
}

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    Key? key,
    required this.userId,
    required TextEditingController editUsernameController,
    required TextEditingController editAboutController,
  })  : _editUsernameController = editUsernameController,
        _editAboutController = editAboutController,
        super(key: key);

  final String userId;
  final TextEditingController _editUsernameController;
  final TextEditingController _editAboutController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Fluttertoast.showToast(msg: 'Error loading data');
        } else if (snapshot.hasData) {
          Map<String, dynamic> userDetails =
              snapshot.data!.data() as Map<String, dynamic>;

          _editUsernameController.text = userDetails['username'];
          _editAboutController.text = userDetails['about'];

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: userDetails['profile_picture'] == ""
                      ? AvatarContainer(
                          MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? sizeSetter(context, 'Width', 0.2)
                              : sizeSetter(context, 'Width', 0.1),
                          false,
                          null,
                          'Profile Screen',
                        )
                      : AvatarContainer(
                          MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? sizeSetter(context, 'Width', 0.15)
                              : sizeSetter(context, 'Width', 0.1),
                          true,
                          userDetails['profile_picture'].toString(),
                          'Profile Screen',
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10.0,
                    left: sizeSetter(context, 'Width', 0.2),
                    right: sizeSetter(context, 'Width', 0.2),
                  ),
                  child: MajorButton(
                    onPress: () async {
                      uploadProfilePicture(userId);
                    },
                    buttonColour: kDarkPrimaryColour,
                    buttonTextColour: kTextPrimaryColour,
                    buttonText: 'SET PROFILE AVATAR',
                    buttonWidth: sizeSetter(context, 'Width', 0.6),
                    buttonHeight: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? sizeSetter(context, 'Height', 0.06)
                        : sizeSetter(context, 'Height', 0.15),
                  ),
                ),
                Divider(
                  thickness: 2.0,
                  color: kPrimaryDividerColour,
                  indent: sizeSetter(context, 'Width', 0.1),
                  endIndent: sizeSetter(context, 'Width', 0.1),
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
                            ? sizeSetter(context, 'Height', 0.3)
                            : sizeSetter(context, 'Height', 0.5),
                        EditDetail(
                          detailController: _editUsernameController,
                          hintText: '',
                          detailHandler: () async {
                            bool usernameChanged =
                                await AccountManagement.changeUserProfileDetail(
                                    'username',
                                    _editUsernameController.text,
                                    userId);

                            if (usernameChanged) {
                              Fluttertoast.showToast(
                                  msg: 'Username change successful');
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Username change failed');
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                            ? sizeSetter(context, 'Height', 0.3)
                            : sizeSetter(context, 'Height', 0.5),
                        EditDetail(
                          detailController: _editAboutController,
                          hintText: '',
                          detailHandler: () async {
                            bool aboutChanged =
                                await AccountManagement.changeUserProfileDetail(
                                    'about', _editAboutController.text, userId);

                            if (aboutChanged) {
                              Fluttertoast.showToast(
                                  msg: 'Username change successful');
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Username change failed');
                            }
                          },
                        ),
                      ),
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
    );
  }
}
