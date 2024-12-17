import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truck_pro/methods/navigate.dart';
import 'package:truck_pro/methods/show_customtoast.dart';
import '../../methods/loading_dialog.dart';
import '../../models/user_model.dart';
import '../BottomNavBar/bottom_nav_bar.dart';

TextEditingController emailController = TextEditingController();
TextEditingController phonenoController = TextEditingController();
TextEditingController nameController = TextEditingController();
String email = emailController.text.trim();
String phoneNo = phonenoController.text.trim();
String name = nameController.text.trim();
File? imageFile;

void selectImage(ImageSource source, setState) async {
  XFile? selectedImage = await ImagePicker().pickImage(source: source);
  if (selectedImage != null) {
    setState(() {
      imageFile = File(selectedImage.path);
    });
  }
}

void showImageOptions(BuildContext context, setState) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "Upload profile picture",
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.gallery, setState);
              },
              leading: const Icon(Icons.photo_album_rounded),
              title: const Text(
                "Select from Gallery",
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.camera, setState);
              },
              leading: const Icon(CupertinoIcons.photo_camera),
              title: const Text(
                "Take new photo",
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

void checkValues(BuildContext context) {
  email = emailController.text.trim();
  phoneNo = phonenoController.text.trim();
  name = nameController.text.trim();

  if (email.isEmpty || phoneNo.isEmpty || name.isEmpty) {
    showFlutterToast(context,
        message: "Please fill all the fields!", errorInfo: 'error');
  } else {
    editProfile(context);
  }
}

void editProfile(BuildContext context) async {
  showLoadingDialog(context, 'Updating Profile...');
  UserModel newUser = UserModel.loggedinUser!;

  if (imageFile != null) {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profileImages")
        .child(newUser.id.toString())
        .putFile(imageFile!);

    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    newUser.image = imageUrl;
  }

  newUser.name = name;
  newUser.phoneno = phoneNo;
  await FirebaseFirestore.instance
      .collection("users")
      .doc(newUser.id)
      .set(newUser.toMap())
      .then(
    (value) {
      Navigator.pop(context);
      UserModel.loggedinUser = newUser;
      showFlutterToast(context, message: 'User Updated!', errorInfo: 'success');
      imageFile = null;
      navigateReplaceAll(
        context,
        BottomNavBarScreen(
          initialIndex: 0,
          role: newUser.role ?? 'guest',
        ),
      );
    },
  );
}
