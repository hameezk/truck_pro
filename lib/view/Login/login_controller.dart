// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truck_pro/methods/loading_dialog.dart';
import 'package:truck_pro/methods/show_customtoast.dart';
import '../../methods/navigate.dart';
import '../../models/user_model.dart';
import '../../utilities/constants.dart';
import '../BottomNavBar/bottom_nav_bar.dart';

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
  showLoadingDialog(context, 'Logging In ...');
  try {
    credentials = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (ex) {
    Navigator.pop(context);
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
  Navigator.pop(context);
  showFlutterToast(context,
      message: "Login successfull!", errorInfo: 'success');
  navigateReplaceAll(
    context,
    BottomNavBarScreen(
      initialIndex: 0,
      role: userModel.role ?? 'guest',
    ),
  );
  return true;
}
