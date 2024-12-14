import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:truck_pro/methods/navigate.dart';
import 'package:truck_pro/models/user_model.dart';
import 'package:truck_pro/view/BottomNavBar/bottom_nav_bar.dart';
import 'package:truck_pro/view/Orders/order_details.dart';
import '../../models/order_model.dart';
import '../../utilities/screen_sizes.dart';
import 'package:flutter/material.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';

class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({super.key});

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.backGroundColor,
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          foregroundImage:
                              NetworkImage(UserModel.loggedinUser!.image ?? ''),
                          backgroundImage:
                              AssetImage(AssetsManager.sampleImage),
                        ),
                        heightSizedBox10,
                        Text(
                          'Welcome back!',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.blackColor),
                        ),
                        Text(
                          UserModel.loggedinUser!.name ?? '',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.primaryColor),
                        )
                      ],
                    ),
                  ),
                ),
                heightSizedBox30,
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          UserModel.setDefaultUsers(context),
                                      child: Text('Active Orders',
                                          style: textThemeData(context)
                                              .headlineMedium!),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: GestureDetector(
                                        onTap: () => navigateReplace(
                                            context,
                                            BottomNavBarScreen(
                                                initialIndex: 2,
                                                role: UserModel
                                                        .loggedinUser!.role ??
                                                    'user')),
                                        child: Text(
                                          "See all",
                                          style:
                                              headingSM.copyWith(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: ListView.separated(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      orderSnapshot.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderListile extends StatelessWidget {
  final OrderModel orderModel;
  const OrderListile({
    super.key,
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigate(context, OrderDetails(orderModel: orderModel)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.backGroundColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderModel.orderItems![0]['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textThemeData(context)
                      .headlineSmall!
                      .copyWith(fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    orderModel.trackingStatus ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textThemeData(context)
                        .headlineSmall!
                        .copyWith(fontSize: 12),
                  ),
                ),
                Text(
                  DateFormat('EEEE, MMM d, yyyy')
                      .format(DateTime.parse(orderModel.createdAt ?? '')),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textThemeData(context).headlineSmall!.copyWith(
                      fontSize: 12,
                      color: AppColors.whiteColor.withOpacity(0.8)),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: AppColors.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
