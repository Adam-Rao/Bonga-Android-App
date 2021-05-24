import 'package:bonga/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      appBar: AppBar(
        backgroundColor: kDarkPrimaryColour,
        centerTitle: true,
        leading: IconButton(
          onPressed: null,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
              fontFamily: kFontFamily,
              fontWeight: kFontWeightSemiBold,
              fontSize: 16.0),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: CircleAvatar(
              backgroundColor: kDarkPrimaryColour,
              child: Icon(
                Icons.person,
                color: kLightPrimaryColour,
                size: 50.0,
              ),
              radius: kGetDeviceWidth(context) * 0.15,
            ),
          ),
          ElevatedButton(
            onPressed: null,
            child: Text(
              'SET PROFILE AVATAR',
              style: TextStyle(
                color: kTextPrimaryColour,
                fontFamily: kFontFamily,
                fontSize: 18.0,
                fontWeight: kFontWeightSemiBold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: kDarkPrimaryColour,
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.60,
                MediaQuery.of(context).size.height * 0.06,
              ),
            ),
          ),
          Divider(
            thickness: 2.0,
            color: kPrimaryDividerColour,
            indent: kGetDeviceWidth(context) * 0.1,
            endIndent: kGetDeviceWidth(context) * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                        color: kTextPrimaryColour,
                        fontFamily: kFontFamily,
                        fontWeight: kFontWeightSemiBold,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      'Placeholder Username',
                      style: TextStyle(
                        color: kTextPrimaryColour,
                        fontFamily: kFontFamily,
                        fontWeight: kFontWeightSemiBold,
                        fontSize: 11.0,
                      ),
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
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 50.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        color: kTextPrimaryColour,
                        fontFamily: kFontFamily,
                        fontWeight: kFontWeightSemiBold,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      'Something pretentious',
                      style: TextStyle(
                        color: kTextPrimaryColour,
                        fontFamily: kFontFamily,
                        fontWeight: kFontWeightSemiBold,
                        fontSize: 11.0,
                      ),
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
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.email,
                  color: Colors.white,
                  size: 50.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: TextStyle(
                        color: kTextPrimaryColour,
                        fontFamily: kFontFamily,
                        fontWeight: kFontWeightSemiBold,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      'someemail@example.com',
                      style: TextStyle(
                        color: kTextPrimaryColour,
                        fontFamily: kFontFamily,
                        fontWeight: kFontWeightSemiBold,
                        fontSize: 11.0,
                      ),
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
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
