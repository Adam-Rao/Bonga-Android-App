import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountManagement {
  static Future<void> createUserDetailsUponAccountCreation(
      String emailAddress, String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Map<String, dynamic> userDetails = {
      "about": "Hey, I'm new here.",
      "about_visible": false,
      "email_address": emailAddress,
      "email_address_visible": false,
      "profile_picture": null,
      "profile_picture_visible": true,
      "username": 'User ${Random().nextInt(100000)}'
    };

    users.doc(userId).set(userDetails).catchError(
        (error) => Fluttertoast.showToast(msg: 'User details not saved.'));
  }

  static Future<bool> changeUserProfileDetail(
      String detailCategory, String detail, String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    switch (detailCategory) {
      case 'username':
        users.doc(userId).update({'username': detail});
        return true;
      case 'profile_picture':
        users.doc(userId).update({'profile_picture': detail});
        return true;
      case 'about':
        users.doc(userId).update({'about': detail});
        return true;
      default:
        break;
    }

    return false;
  }

  static Future<bool> changeUserPrivacyDetail(
      String privacyCategory, bool detail, String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    switch (privacyCategory) {
      case 'about-visibility':
        users.doc(userId).update({'about_visible': detail});
        return true;
      case 'email-address-visibility':
        users.doc(userId).update({'email_address_visible': detail});
        return true;
      case 'profile-picture-visibility':
        users.doc(userId).update({'profile_picture_visible': detail});
        return true;
      default:
        break;
    }

    return false;
  }
}
