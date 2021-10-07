import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void uploadProfilePicture(String userID) async {
  final status = await Permission.storage.request();
  if (status == PermissionStatus.granted) {
    final ImagePicker _picker = ImagePicker();
    late File _image;

    final _selectedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (_selectedFile != null) {
      _image = File(_selectedFile.path);

      await FirebaseStorage.instance
          .ref('profile_avatars/$userID/${DateTime.now()}')
          .putFile(_image)
          .then(
            (taskSnapshot) => {
              taskSnapshot.ref.getDownloadURL().then((imageUrl) => {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(userID)
                        .update({'profile_picture': imageUrl})
                  })
            },
          );
    }
  }
  if (status == PermissionStatus.permanentlyDenied) {
    Fluttertoast.showToast(msg: 'Enable storage permission in your settings');
  }
}
