import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../methods/loading_dialog.dart';
import '../methods/show_customtoast.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneno;
  String? image;
  String? role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneno,
    required this.image,
    required this.role,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    email = map["email"];
    phoneno = map["phoneno"];
    image = map["image"];
    role = map["role"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneno": phoneno,
      "image": image,
      "role": role,
    };
  }

  static UserModel? loggedinUser;
  static String defaultImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSriFFJXaLLV3g1bFT8PrDRFbD50XjQ7lm_0g&s';

  static List<UserModel> defaultUsers = [
    UserModel(
      id: '',
      name: 'Admin',
      email: 'admin@fmcgpro.com',
      phoneno: '01234561',
      image: defaultImage,
      role: 'admin',
    ),
    UserModel(
      id: '',
      name: 'Dispatcher',
      email: 'user@fmcgpro.com',
      phoneno: '01234562',
      image: defaultImage,
      role: 'user',
    ),
    UserModel(
      id: '',
      name: 'Driver',
      email: 'driver@fmcgpro.com',
      phoneno: '01234563',
      image: defaultImage,
      role: 'driver',
    ),
  ];

  static Future<void> setDefaultUsers(BuildContext context) async {
    for (var defaultUser in defaultUsers) {
      UserCredential? credentials;
      showLoadingDialog(context, 'Signing Up...');
      try {
        credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: defaultUser.email!, password: 'password');
      } on FirebaseAuthException catch (ex) {
        Navigator.pop(context);
        showFlutterToast(context,
            message: ex.code.toString(), errorInfo: 'error');
      }

      if (credentials != null) {
        String uid = credentials.user!.uid;
        UserModel newUser = UserModel(
          id: (defaultUser.id == '') ? uid : defaultUser.id,
          role: defaultUser.role,
          email: defaultUser.email,
          name: defaultUser.name,
          image: defaultUser.image,
          phoneno: defaultUser.phoneno,
        );
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set(newUser.toMap())
            .then(
          (value) {
            Navigator.pop(context);
            showFlutterToast(context,
                message: 'New user created!', errorInfo: 'success');
          },
        );
      }
    }
  }
}
