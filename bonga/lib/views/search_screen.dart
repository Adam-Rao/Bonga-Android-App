import 'package:bonga/constants.dart';
import 'package:bonga/models/search_result_model.dart';
import 'package:bonga/views/components/item_row.dart';
import 'package:bonga/views/components/profile_avatar.dart';
import 'package:bonga/views/components/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String? _searchKey;
  const SearchScreen({String? searchKey}) : _searchKey = searchKey;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .startAt([widget._searchKey]).endAt(
              [widget._searchKey! + '\uf8ff']).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AppText(
            'Something went wrong',
            kFontWeightSemiBold,
            18.0,
            kTextPrimaryColour,
          );
        } else if (snapshot.hasData) {
          int searchResultsSize = snapshot.data!.docs.length;
          List<SearchResultModel> searchResults = snapshot.data!.docs
              .map((doc) => SearchResultModel(
                    doc['about'],
                    doc['about_visible'],
                    doc['profile_picture'],
                    doc['profile_picture_visible'],
                    doc['username'],
                  ))
              .toList();

          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  kNormalPush(context, '/chat');
                },
                child: ItemRow(
                  [
                    AvatarContainer(
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? kSizeSetter(context, 'Height', 0.05)
                          : kSizeSetter(context, 'Height', 0.1),
                      false,
                      null,
                      'Home Screen',
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? kSizeSetter(context, 'Width', 0.07)
                          : kSizeSetter(context, 'Height', 0.1),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: AppText(
                              searchResults[index].about!,
                              kFontWeightSemiBold,
                              16.0,
                              kTextPrimaryColour,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: kSizeSetter(context, 'Width', 0.05),
                    ),
                  ],
                  MainAxisAlignment.spaceBetween,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 2.0,
              color: kPrimaryDividerColour,
              indent: MediaQuery.of(context).orientation == Orientation.portrait
                  ? kSizeSetter(context, 'Width', 0.15)
                  : kSizeSetter(context, 'Width', 0.07),
              endIndent: kSizeSetter(context, 'Width', 0.02),
            ),
            itemCount: searchResultsSize,
            padding: EdgeInsets.all(10.0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: AppText(
            'Search for users',
            kFontWeightSemiBold,
            16.0,
            kTextPrimaryColour,
          ),
        );
      },
    );
  }
}
