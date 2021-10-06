import 'dart:async';

import 'package:bonga/constants.dart';
import 'package:bonga/models/search_result_model.dart';
import 'package:bonga/views/components/item_row.dart';
import 'package:bonga/views/components/profile_avatar.dart';
import 'package:bonga/views/components/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
  final TextEditingController _searchController = TextEditingController();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SearchResultModel> _searchResults = [];

  bool _searching = false;

  Future<List<SearchResultModel>> _searchUsers(String searchText) async {
    List<SearchResultModel> userDetails = [];

    String userID = FirebaseAuth.instance.currentUser!.uid;

    setState(() {
      _searching = true;
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: searchText)
        .where('userID', isNotEqualTo: userID)
        .get()
        .then((snapshot) => snapshot.docs.forEach((doc) {
              SearchResultModel userDetail = SearchResultModel(
                  doc['about'],
                  doc['about_visible'],
                  doc['profile_picture'],
                  doc['profile_picture_visible'],
                  doc['username'],
                  doc['userID'],
                  doc['isOnline']);
              userDetails.add(userDetail);
            }));

    setState(() {
      _searching = false;
    });

    return userDetails;
  }

  @override
  void dispose() {
    widget._searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget._searchController,
                    decoration: InputDecoration(
                      hintText: 'Search users',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintStyle: TextStyle(
                        fontFamily: kFontFamily,
                        fontSize: kHintTextSize,
                        fontWeight: kFontWeightRegular,
                        color: Colors.white,
                      ),
                    ),
                    style: TextStyle(
                      color: kTextPrimaryColour,
                      fontFamily: kFontFamily,
                      fontSize: 16.0,
                      fontWeight: kFontWeightRegular,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final results =
                        await _searchUsers(widget._searchController.text);
                    setState(() {
                      _searchResults = results;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          _searchResults.length == 0
              ? Center(
                  child: _searching == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : AppText(
                          'No Search Results',
                          kFontWeightSemiBold,
                          14.0,
                          kTextPrimaryColour,
                        ),
                )
              : ListView.separated(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: kLightPrimaryColour,
                        child: ItemRow(
                          [
                            Expanded(
                              child: AvatarContainer(
                                20.0,
                                false,
                                null,
                                'Search Screen',
                              ),
                            ),
                            Expanded(
                              child: AppText(
                                _searchResults[index].username!,
                                kFontWeightSemiBold,
                                12.0,
                                kPrimaryTextColour,
                              ),
                            ),
                            ItemRow(
                              [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/profile',
                                        arguments: {
                                          'username':
                                              _searchResults[index].username,
                                          'about': _searchResults[index].about,
                                          'profile_picture': _searchResults[index].profilePicture,
                                          'profile_picture_visible':
                                              _searchResults[index]
                                                  .profilePictureVisible,
                                          'about_visible': _searchResults[index]
                                              .aboutVisible,
                                        });
                                  },
                                  child: AppText(
                                    'VIEW PROFILE',
                                    kFontWeightSemiBold,
                                    12.0,
                                    kPrimaryTextColour,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/chat',
                                        arguments: {
                                          'username':
                                              _searchResults[index].username,
                                          'isOnline':
                                              _searchResults[index].isOnline,
                                          'userID':
                                              _searchResults[index].userID,
                                          'profile_picture_visible':
                                              _searchResults[index]
                                                  .profilePictureVisible,
                                          'profile_picture':
                                              _searchResults[index]
                                                  .profilePicture,
                                        });
                                  },
                                  child: AppText(
                                    'CHAT',
                                    kFontWeightSemiBold,
                                    12.0,
                                    kPrimaryTextColour,
                                  ),
                                ),
                              ],
                              MainAxisAlignment.spaceBetween,
                            ),
                          ],
                          MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container();
                  },
                  shrinkWrap: true,
                ),
        ],
      ),
    );
  }
}
