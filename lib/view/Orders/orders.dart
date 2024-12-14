import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truck_pro/methods/navigate.dart';
import 'package:truck_pro/utilities/app_colors.dart';
import 'package:truck_pro/view/Orders/create_order.dart';
import 'package:truck_pro/widgets/custom_appbar.dart';

import '../../models/order_model.dart';
import '../../models/user_model.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';
import '../Home/home_screen_user.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "My Orders",
              backGroundColor: AppColors.backGroundColor,
            ),
            Expanded(
              child: Container(
                width: screenWidth(context),
                decoration: const BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      heightSizedBox20,
                      Expanded(
                        child: Column(
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("orders")
                                  .where("userId",
                                      isEqualTo: UserModel.loggedinUser!.id)
                                  .where("status", isEqualTo: 'active')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasData) {
                                    QuerySnapshot orderSnapshot =
                                        snapshot.data as QuerySnapshot;
                                    print("Data: ${orderSnapshot.docs}");
                                    return (orderSnapshot.docs.length > 0)
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              itemCount:
                                                  orderSnapshot.docs.length,
                                              itemBuilder: (context, index) {
                                                OrderModel orderModel =
                                                    OrderModel.fromMap(
                                                        orderSnapshot
                                                                .docs[index]
                                                                .data()
                                                            as Map<String,
                                                                dynamic>);
                                                return OrderListile(
                                                  orderModel: orderModel,
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      SizedBox(
                                                height: 7,
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            child: Center(
                                              child: Text(
                                                "No Active Orders To Show!",
                                                style: headingSM,
                                              ),
                                            ),
                                          );
                                  } else if (snapshot.hasError) {
                                    return Expanded(
                                      child: Center(
                                        child: Text(
                                          snapshot.error.toString(),
                                          style: headingSM,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Expanded(
                                      child: Center(
                                        child: Text(
                                          "No Orders to show!",
                                          style: headingSM,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return Expanded(
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigate(context, CreateOrder());
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.add,
          color: AppColors.backGroundColor,
        ),
      ),
    );
  }
}
