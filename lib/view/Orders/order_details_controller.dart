import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truck_pro/methods/loading_dialog.dart';
import 'package:truck_pro/models/user_model.dart';
import '../../methods/show_customtoast.dart';
import '../../models/order_model.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/screen_sizes.dart';

PermissionStatus cameraPermissionStatus = PermissionStatus.denied;
MobileScannerController mobileScannerController = MobileScannerController(
  detectionSpeed: DetectionSpeed.noDuplicates,
  torchEnabled: false,
);
File? imageFile;
TextEditingController remarksController = TextEditingController();
String remarks = '';

Future<void> pickImage(ImageSource source, Function setState) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? pickedFile = await _picker.pickImage(source: source);

  if (pickedFile != null) {
    setState(() {
      imageFile = File(pickedFile.path);
    });
  }
}

void validateDelivery(BuildContext context, OrderModel orderModel) {
  remarks = remarksController.text.trim();

  if (imageFile == null) {
    showFlutterToast(context,
        message: "Please submit picture proof of delivery!",
        errorInfo: 'error');
  } else {
    deliverOrder(context, orderModel);
  }
}

acceptOrder(BuildContext context, OrderModel orderModel) async {
  OrderModel updatedOrderModel = orderModel;
  updatedOrderModel.isAccepted = true;
  updatedOrderModel.trackingStatus = 'Pending';
  updatedOrderModel.driverId = UserModel.loggedinUser!.id;

  try {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(updatedOrderModel.orderId)
        .set(updatedOrderModel.toMap())
        .then(
      (value) {
        showFlutterToast(context,
            message: 'Order accepted!', errorInfo: 'success');
      },
    );
  } on FirebaseException catch (e) {
    showFlutterToast(context, message: e.toString(), errorInfo: 'error');
  } catch (e) {
    showFlutterToast(context,
        message: 'An error occoured!', errorInfo: 'error');
  }
}

Future<void> pickOrder(BuildContext context, OrderModel orderModel) async {
  OrderModel updatedOrderModel = orderModel;
  updatedOrderModel.trackingStatus = 'In Progress';
  updatedOrderModel.isPicked = true;

  try {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(updatedOrderModel.orderId)
        .set(updatedOrderModel.toMap())
        .then(
      (value) {
        showFlutterToast(context,
            message: 'Order Picked!', errorInfo: 'success');
      },
    );
  } on FirebaseException catch (e) {
    showFlutterToast(context, message: e.toString(), errorInfo: 'error');
  } catch (e) {
    showFlutterToast(context,
        message: 'An error occoured!', errorInfo: 'error');
  }
}

deliverOrder(BuildContext context, OrderModel orderModel) async {
  showLoadingDialog(context, 'Uploading Picture...');
  UploadTask uploadTask = FirebaseStorage.instance
      .ref("orders")
      .child(orderModel.orderId.toString())
      .putFile(imageFile!);

  TaskSnapshot snapshot = await uploadTask;

  String imageUrl = await snapshot.ref.getDownloadURL();
  Navigator.pop(context);
  OrderModel updatedOrderModel = orderModel;
  updatedOrderModel.isDelivered = true;
  updatedOrderModel.deliveryRemarks = remarks;
  updatedOrderModel.deliveryProof = imageUrl;
  updatedOrderModel.trackingStatus = 'Delivered';
  updatedOrderModel.deliveredAt = DateTime.now().toString();

  try {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(updatedOrderModel.orderId)
        .set(updatedOrderModel.toMap())
        .then(
      (value) {
        imageFile = null;
        remarksController.text = '';
        Navigator.pop(context);
        showFlutterToast(context,
            message: 'Order delivered!', errorInfo: 'success');
      },
    );
  } on FirebaseException catch (e) {
    showFlutterToast(context, message: e.toString(), errorInfo: 'error');
  } catch (e) {
    showFlutterToast(context,
        message: 'An error occoured!', errorInfo: 'error');
  }
}

showDeliveryProofDialog(BuildContext context, OrderModel orderModel) {
  AlertDialog dialog = AlertDialog(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Id:",
          textAlign: TextAlign.left,
          maxLines: 5,
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "${orderModel.orderId}",
          textAlign: TextAlign.left,
          maxLines: 5,
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      ],
    ),
    content: SingleChildScrollView(
      child: StatefulBuilder(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Delivered at: ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(orderModel.deliveredAt!))}',
              maxLines: 5,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            // Image Preview
            Image.network(
              orderModel.deliveryProof!,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),

            // Text Field for Remarks
            SizedBox(
              width: screenWidth(context) * 0.9,
              child: TextField(
                controller: TextEditingController(
                    text: orderModel.deliveryRemarks ?? ''),
                readOnly: true,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Remarks",
                  hintText: "No Remarks",
                ),
              ),
            ),
          ],
        );
      }),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Close"),
      ),
    ],
  );

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return dialog;
      });
}
