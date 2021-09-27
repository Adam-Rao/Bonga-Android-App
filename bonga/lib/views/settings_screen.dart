import 'package:bonga/controllers/account_management.dart';
import 'package:bonga/controllers/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';
import 'components/app_bar.dart';
import 'components/form_field.dart';
import 'components/item_row.dart';
import 'components/major_button.dart';
import 'components/popup_menu.dart';
import 'components/profile_avatar.dart';
import 'components/text.dart';

class SettingsScreen extends StatelessWidget {
  void _settingsListController(BuildContext context, int index) {
    switch (index) {
      case 0:
        kShowBottomSheet(
          context,
          MediaQuery.of(context).orientation == Orientation.portrait
              ? kSizeSetter(context, 'Height', 0.5)
              : kSizeSetter(context, 'Height', 0.8),
          ChangePasswordForm(),
        );
        break;
      case 1:
        kShowBottomSheet(
          context,
          MediaQuery.of(context).orientation == Orientation.portrait
              ? kSizeSetter(context, 'Height', 0.4)
              : kSizeSetter(context, 'Height', 0.6),
          DeleteAccountDialog(),
        );
        break;
      case 2:
        break;
      case 3:
        kShowBottomSheet(
          context,
          kSizeSetter(context, 'Height', 0.4),
          PrivacySettingsDialog(),
        );
        break;
      default:
    }
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      appBar: UniversalAppBar(
        actions: [
          PopUpMenu('SettingsScreen'),
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
          'Settings',
          kFontWeightSemiBold,
          16.0,
          kTextPrimaryColour,
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(msg: 'Failed loading user data');
            return Center(
              child: Text('Error'),
            );
          } else if (snapshot.hasData) {
            print(snapshot.data!.data());
            Map<String, dynamic> userDetail =
                snapshot.data!.data() as Map<String, dynamic>;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? kSizeSetter(context, 'Height', 0.2)
                          : kSizeSetter(context, 'Height', 0.3),
                      child: ItemRow(
                        [
                          AvatarContainer(kSizeSetter(context, 'Width', 0.1),
                              false, null, 'Settings Screen'),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                'Username',
                                kFontWeightSemiBold,
                                16.0,
                                kTextPrimaryColour,
                              ),
                              SizedBox(height: 2.0),
                              AppText(
                                userDetail['username'],
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
                  ),
                  Divider(
                    thickness: 2.0,
                    color: kPrimaryDividerColour,
                    indent: kSizeSetter(context, 'Width', 0.1),
                    endIndent: kSizeSetter(context, 'Width', 0.1),
                  ),
                  ListView.separated(
                    padding: EdgeInsets.all(20.0),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _settingsListController(context, index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: kAccountSettingsList[index],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.transparent,
                    ),
                    itemCount: kAccountSettingsList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
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

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _changePasswordKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _changePasswordKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AuthFormField(
              textFieldController: _newPasswordController,
              hintText: 'New Password',
              emptyFieldValidatorError: kEmptyPasswordValidatorError,
              invalidFieldValidatorError: kInvalidPasswordValidatorError,
              keyboardType: TextInputType.visiblePassword,
              isPasswordField: true,
            ),
            SizedBox(
              height: kSizeSetter(context, 'Height', 0.05),
            ),
            AuthFormField(
              textFieldController: _confirmNewPasswordController,
              hintText: 'Re-enter your new password',
              emptyFieldValidatorError: kEmptyPasswordValidatorError,
              invalidFieldValidatorError: kInvalidPasswordValidatorError,
              keyboardType: TextInputType.visiblePassword,
              isPasswordField: true,
            ),
            SizedBox(
              height: kSizeSetter(context, 'Height', 0.05),
            ),
            MajorButton(
              onPress: () {
                Navigator.pop(context);
              },
              buttonColour: kLightPrimaryColour,
              buttonTextColour: kPrimaryTextColour,
              buttonText: 'CONFIRM',
              buttonWidth: kSizeSetter(context, 'Width', kAuthButtonWidthRatio),
              buttonHeight:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? kSizeSetter(context, 'Height', kAuthButtonHeightRatio)
                      : kSizeSetter(context, 'Height', 0.15),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: AppText(
              'Are you sure?',
              kFontWeightSemiBold,
              18,
              kTextPrimaryColour,
            ),
          ),
          Expanded(
            child: Center(
              child: AppText(
                kDeleteAccountInformation,
                kFontWeightSemiBold,
                18,
                kTextPrimaryColour,
              ),
            ),
          ),
          MajorButton(
            onPress: () async {
              bool userDeleted = await Authentication.deleteUser(context);
              if (userDeleted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
                Fluttertoast.showToast(msg: 'Account Deletion Successful');
              } else {
                Fluttertoast.showToast(msg: 'Account Deletion Failed.');
              }
            },
            buttonColour: kLightPrimaryColour,
            buttonTextColour: kPrimaryTextColour,
            buttonText: 'Delete Account',
            buttonWidth: kSizeSetter(context, 'Width', kAuthButtonWidthRatio),
            buttonHeight:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? kSizeSetter(context, 'Height', kAuthButtonHeightRatio)
                    : kSizeSetter(context, 'Height', 0.15),
          ),
        ],
      ),
    );
  }
}

class PrivacySettingsDialog extends StatelessWidget {
  const PrivacySettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: AppText(
            'Privacy Settings',
            kFontWeightSemiBold,
            18,
            kTextPrimaryColour,
          ),
        ),
        ItemRow(
          [
            AppText(
              'Profile Picture Visible To Everyone',
              kFontWeightSemiBold,
              13,
              kTextPrimaryColour,
            ),
            PrivacySettingsSwitch(
              privacySetting: 'profile_picture_visible',
            ),
          ],
          MainAxisAlignment.spaceEvenly,
        ),
        ItemRow(
          [
            AppText(
              'About Visible To Everyone',
              kFontWeightSemiBold,
              13,
              kTextPrimaryColour,
            ),
            SizedBox(
              width: 10.0,
            ),
            PrivacySettingsSwitch(
              privacySetting: 'about_visible',
            ),
          ],
          MainAxisAlignment.spaceEvenly,
        ),
      ],
    );
  }
}

class PrivacySettingsSwitch extends StatefulWidget {
  final String? _privacySetting;
  const PrivacySettingsSwitch({Key? key, String? privacySetting})
      : _privacySetting = privacySetting,
        super(key: key);

  @override
  _PrivacySettingsSwitchState createState() => _PrivacySettingsSwitchState();
}

class _PrivacySettingsSwitchState extends State<PrivacySettingsSwitch> {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(msg: 'Error showing data');
          }
          if (snapshot.hasData) {
            Map<String, dynamic> userDetail =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              child: FlutterSwitch(
                height: 15.0,
                width: 35.0,
                borderRadius: 30.0,
                toggleSize: 15.0,
                value: userDetail[widget._privacySetting],
                onToggle: (value) {
                  AccountManagement.changeUserPrivacyPreference(
                    widget._privacySetting!,
                    value,
                    userId,
                  );
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
