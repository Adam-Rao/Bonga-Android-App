import 'package:bonga/constants.dart';
import 'package:bonga/controllers/authentication.dart';
import 'package:bonga/handlers/connectivity_handler.dart';
import 'package:bonga/handlers/navigation_handler.dart';
import 'package:bonga/handlers/size_setter_handler.dart';
import 'package:bonga/views/components/edit_detail.dart';
import 'package:bonga/views/components/major_button.dart';
import 'package:bonga/views/components/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'components/item_row.dart';

class WelcomeScreen extends StatelessWidget {
  final List<Widget> _appBanner = [
    AppText(
      'Bong',
      kFontWeightSemiBold,
      24.0,
      kTextPrimaryColour,
    ),
    Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/app_icon.png',
          ),
          fit: BoxFit.contain,
        ),
      ),
    ),
  ];

  final TextEditingController _forgotPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      body: Center(
        child: PotraitWelcomeScreenBody(
          appBanner: _appBanner,
          forgotPasswordController: _forgotPasswordController,
        ),
      ),
    );
  }
}

class PotraitWelcomeScreenBody extends StatefulWidget {
  const PotraitWelcomeScreenBody({
    Key? key,
    required List<Widget> appBanner,
    required TextEditingController forgotPasswordController,
  })  : _appBanner = appBanner,
        _forgotPasswordController = forgotPasswordController,
        super(key: key);

  final List<Widget> _appBanner;
  final TextEditingController _forgotPasswordController;

  @override
  _PotraitWelcomeScreenBodyState createState() =>
      _PotraitWelcomeScreenBodyState();
}

class _PotraitWelcomeScreenBodyState extends State<PotraitWelcomeScreenBody> {
  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        normalPush(context, '/home');
      });
    }
  }

  void _resetPassword() async {
    bool userConnected = await checkConnectivity();

    if (userConnected) {
      bool passwordResetSent = await Authentication.resetPassword(
          widget._forgotPasswordController.text);

      if (passwordResetSent) {
        Fluttertoast.showToast(msg: 'Password reset link sent to email');
      } else {
        Fluttertoast.showToast(
            msg: 'If you are a user, ensure valid email is provided');
      }
    } else {
      Fluttertoast.showToast(msg: 'No internet connectivity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? sizeSetter(context, 'Height', 0.2)
              : sizeSetter(context, 'Height', 0.1),
          child: Center(
            child: ItemRow(
              widget._appBanner,
              MainAxisAlignment.center,
            ),
          ),
        ),
        SizedBox(
          height: sizeSetter(context, 'Height', 0.1),
        ),
        Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? sizeSetter(context, 'Height', 0.35)
              : sizeSetter(context, 'Height', 0.6),
          child: Column(
            children: [
              MajorButton(
                onPress: () {
                  normalPush(context, '/registration');
                },
                buttonColour: kDarkPrimaryColour,
                buttonTextColour: kTextPrimaryColour,
                buttonText: 'REGISTRATION',
                buttonWidth:
                    sizeSetter(context, 'Width', kAuthButtonWidthRatio),
                buttonHeight:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? sizeSetter(context, 'Height', kAuthButtonHeightRatio)
                        : sizeSetter(context, 'Height', 0.15),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? sizeSetter(context, 'Height', 0.05)
                        : sizeSetter(context, 'Height', 0.08),
              ),
              MajorButton(
                onPress: () {
                  normalPush(context, '/login');
                },
                buttonColour: kLightPrimaryColour,
                buttonTextColour: kPrimaryTextColour,
                buttonText: 'LOGIN',
                buttonWidth:
                    sizeSetter(context, 'Width', kAuthButtonWidthRatio),
                buttonHeight:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? sizeSetter(context, 'Height', kAuthButtonHeightRatio)
                        : sizeSetter(context, 'Height', 0.15),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? sizeSetter(context, 'Height', 0.05)
                        : sizeSetter(context, 'Height', 0.01),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    kShowBottomSheet(
                      context,
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? sizeSetter(context, 'Height', 0.3)
                          : sizeSetter(context, 'Height', 0.5),
                      EditDetail(
                        detailController: widget._forgotPasswordController,
                        hintText: 'Enter your email address',
                        detailHandler: _resetPassword,
                      ),
                    );
                  },
                  child: AppText(
                    'Forgot your password?',
                    kFontWeightSemiBold,
                    14.0,
                    kTextPrimaryColour,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
