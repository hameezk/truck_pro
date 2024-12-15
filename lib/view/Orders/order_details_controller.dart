import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truck_pro/models/user_model.dart';

import '../../methods/show_customtoast.dart';
import '../../models/order_model.dart';

acceptOrder(BuildContext context, OrderModel orderModel) async {
  OrderModel updatedOrderModel = orderModel;
  updatedOrderModel.isAccepted = true;
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

pickOrder(BuildContext context, OrderModel orderModel) async {
  OrderModel updatedOrderModel = orderModel;
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
  OrderModel updatedOrderModel = orderModel;
  updatedOrderModel.isDelivered = true;
  updatedOrderModel.deliveredAt = DateTime.now().toString();

  try {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(updatedOrderModel.orderId)
        .set(updatedOrderModel.toMap())
        .then(
      (value) {
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
