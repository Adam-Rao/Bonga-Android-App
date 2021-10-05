import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountManagement {
  static Future<void> createUserDetailsUponAccountCreation(
      String emailAddress, String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');

    int _generatedUsername = Random().nextInt(100000);

    Map<String, dynamic> userDetails = {
      "about": "Hey, I'm new here.",
      "about_visible": false,
      "isOnline": false,
      "profile_picture": "",
      "profile_picture_visible": true,
      "userID": userId,
      "username": 'User $_generatedUsername'
    };

    Map<String, String> roomDetails = {"room_name": 'User $_generatedUsername'};

    users.doc(userId).set(userDetails).catchError(
        (error) => Fluttertoast.showToast(msg: 'User details not saved.'));

    rooms.doc(userId).set(roomDetails).catchError(
        (error) => Fluttertoast.showToast(msg: 'something went wrong'));
  }

  static Future<bool> changeUserProfileDetail(
      String detailCategory, String detail, String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');

    switch (detailCategory) {
      case 'username':
        users.doc(userId).update({'username': detail});
        rooms.doc(userId).update({'room_name': detail});
        return true;
      case 'about':
        users.doc(userId).update({'about': detail});
        return true;
      default:
        break;
    }

    return false;
  }

  static Future<bool> changeUserPrivacyPreference(
      String privacyCategory, bool visibile, String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    switch (privacyCategory) {
      case 'about_visible':
        users.doc(userId).update({'about_visible': visibile});
        return true;
      case 'profile_picture_visible':
        users.doc(userId).update({'profile_picture_visible': visibile});
        return true;
      default:
        break;
    }

    return false;
  }
}
