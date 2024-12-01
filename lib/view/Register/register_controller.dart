import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truck_pro/methods/navigate.dart';
import 'package:truck_pro/methods/show_customtoast.dart';
import '../../methods/loading_dialog.dart';
import '../../models/user_model.dart';
import '../BottomNavBar/bottom_nav_bar.dart';

bool hidePassword = true;
bool hideReEnterPassword = true;
bool registerAsUser = true;
TextEditingController emailController = TextEditingController();
TextEditingController phonenoController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController cPasswordController = TextEditingController();
String email = emailController.text.trim();
String password = passwordController.text.trim();
String cPassword = cPasswordController.text.trim();
String phoneNo = phonenoController.text.trim();
String name = nameController.text.trim();

void checkValues(BuildContext context) {
  email = emailController.text.trim();
  password = passwordController.text.trim();
  cPassword = cPasswordController.text.trim();
  phoneNo = phonenoController.text.trim();
  name = nameController.text.trim();

  if (email.isEmpty ||
      password.isEmpty ||
      cPassword.isEmpty ||
      phoneNo.isEmpty ||
      name.isEmpty) {
    showFlutterToast(context,
        message: "Please fill all the fields!", errorInfo: 'error');
  } else if (password != cPassword) {
    showFlutterToast(context,
        message: "Passwords donot match!", errorInfo: 'error');
  } else {
    signUp(context);
  }
}

void signUp(BuildContext context) async {
  UserCredential? credentials;
  showLoadingDialog(context, 'Signing Up...');
  try {
    credentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (ex) {
    Navigator.pop(context);
    showFlutterToast(context, message: ex.code.toString(), errorInfo: 'error');
  }

  if (credentials != null) {
    String uid = credentials.user!.uid;
    UserModel newUser = UserModel(
      id: uid,
      role: (registerAsUser) ? 'user' : 'driver',
      email: email,
      name: name,
      image: UserModel.defaultImage,
      phoneno: phoneNo,
    );
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(newUser.toMap())
        .then(
      (value) {
        Navigator.pop(context);
        UserModel.loggedinUser = newUser;
        showFlutterToast(context,
            message: 'New user created!', errorInfo: 'success');

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
}
