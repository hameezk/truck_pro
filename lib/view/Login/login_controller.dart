// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truck_pro/methods/show_customtoast.dart';
import 'package:truck_pro/view/Home/home_screen_user.dart';
import '../../methods/navigate.dart';
import '../../models/user_model.dart';
import '../../utilities/constants.dart';
import '../Home/home_screen_admin.dart';
import '../Home/home_screen_driver.dart';

TextEditingController userNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

Future<bool> validateLoginFields(BuildContext context) async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email.isEmpty) {
    showFlutterToast(
      context,
      message: 'Email cannot be empty',
      errorInfo: 'error',
    );
    return false;
  } else if (password.isEmpty) {
    showFlutterToast(
      context,
      message: 'Password cannot be empty',
      errorInfo: 'error',
    );
    return false;
  } else if (!emailRegExp.hasMatch(email)) {
    showFlutterToast(
      context,
      message: 'Please enter a valid email',
      errorInfo: 'error',
    );
    return false;
  } else {
    return logIn(email, password, context);
  }
}

Future<bool> logIn(String email, String password, BuildContext context) async {
  UserCredential? credentials;

  try {
    credentials = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (ex) {
    showFlutterToast(context,
        message: ex.message.toString(), errorInfo: 'error');
    return false;
  }

  String uid = credentials.user!.uid;

  DocumentSnapshot userData =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  UserModel userModel =
      UserModel.fromMap(userData.data() as Map<String, dynamic>);

  UserModel.loggedinUser = userModel;
  showFlutterToast(context,
      message: "Login successfull!", errorInfo: 'success');
  navigateReplaceAll(
    context,
    (UserModel.loggedinUser!.role == 'admin')
        ? const HomeScreenAdmin()
        : (UserModel.loggedinUser!.role == 'driver')
            ? const HomeScreenDriver()
            : const HomeScreenUser(),
  );
  return true;
}
