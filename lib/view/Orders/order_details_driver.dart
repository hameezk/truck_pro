import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truck_pro/models/order_model.dart';
import 'package:truck_pro/models/user_model.dart';
import 'package:truck_pro/res/helpers/firebase_helper.dart';
import 'package:truck_pro/utilities/app_colors.dart';
import 'package:truck_pro/widgets/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/chats_model.dart';
import '../../res/helpers/get_chatroom.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';
import '../Chats/chatroom.dart';
import 'order_details_controller.dart';

class OrderDetailsDriver extends StatefulWidget {
  final OrderModel orderModel;
  const OrderDetailsDriver({super.key, required this.orderModel});

  @override
  State<OrderDetailsDriver> createState() => _OrderDetailsDriverState();
}

class _OrderDetailsDriverState extends State<OrderDetailsDriver> {
  UserModel? dispatcherModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                title: 'Order Details',
                showBackButton: true,
                backGroundColor: AppColors.backGroundColor,
                foreGroundColor: AppColors.blackColor,
              ),
              StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection("orders")
                      .where("orderId", isEqualTo: widget.orderModel.orderId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot orderSnapshot =
                            snapshot.data as QuerySnapshot;
                        OrderModel orderModel = OrderModel.fromMap(
                            orderSnapshot.docs[0].data()
                                as Map<String, dynamic>);
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 0, left: 0, right: 0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 20, right: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // const SizedBox(height: 5),
                                          buildTrackingProductCard(context),
                                          const SizedBox(height: 15),

                                          Row(
                                            children: [
                                              Text(
                                                'Order ID:',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                orderModel.orderId!,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  showLocation(
                                                      orderModel
                                                          .pickuplatitude!,
                                                      orderModel
                                                          .pickupLongitude!);
                                                },
                                                child: TrackingStatusWidget(
                                                  statusImage:
                                                      AssetsManager.homeIcon,
                                                  statusTitle: 'Pickup Address',
                                                  statusSubTitle: orderModel
                                                          .pickupLocation ??
                                                      '',
                                                  titleColor:
                                                      AppColors.blackColor,
                                                  subTitleColor:
                                                      AppColors.blackColor,
                                                  imageColor:
                                                      (orderModel.isPicked ??
                                                              false)
                                                          ? Colors.greenAccent
                                                          : AppColors.greyColor,
                                                  verticalDotedLine:
                                                      VerticalDotedLineWidget(
                                                    lineColor: (orderModel
                                                                .isPicked ??
                                                            false)
                                                        ? Colors.greenAccent
                                                        : AppColors.greyColor,
                                                  ),
                                                  circleAvatarColor:
                                                      (orderModel.isPicked ??
                                                              false)
                                                          ? Colors.greenAccent
                                                          : AppColors.greyColor,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showLocation(
                                                      orderModel
                                                          .deliverylatitude!,
                                                      orderModel
                                                          .deliveryLongitude!);
                                                },
                                                child: TrackingStatusWidget(
                                                  statusImage:
                                                      AssetsManager.work,
                                                  statusTitle:
                                                      'Delivery Address',
                                                  statusSubTitle: orderModel
                                                          .deliveryLocation ??
                                                      '',
                                                  titleColor:
                                                      AppColors.blackColor,
                                                  subTitleColor:
                                                      AppColors.blackColor,
                                                  imageColor:
                                                      (orderModel.isDelivered ??
                                                              false)
                                                          ? Colors.greenAccent
                                                          : AppColors.greyColor,
                                                  circleAvatarColor:
                                                      (orderModel.isDelivered ??
                                                              false)
                                                          ? Colors.greenAccent
                                                          : AppColors.greyColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          (orderModel.isAccepted ?? false)
                                              ? (dispatcherModel == null)
                                                  ? FutureBuilder(
                                                      future: FirebaseHelper
                                                          .getUserModelById(
                                                              orderModel
                                                                  .userId!),
                                                      builder: (context, snap) {
                                                        if (snap.connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          dispatcherModel =
                                                              snap.data!;
                                                          return buildDispatcherCard(
                                                              dispatcherModel!,
                                                              context);
                                                        } else {
                                                          return Container();
                                                        }
                                                      })
                                                  : buildDispatcherCard(
                                                      dispatcherModel!, context)
                                              : Container(),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          InkWell(
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              (orderModel
                                                              .isAccepted ??
                                                          false) ==
                                                      false
                                                  ? acceptOrder(context,
                                                      orderModel)
                                                  : (orderModel
                                                                  .isAccepted ==
                                                              true &&
                                                          orderModel
                                                                  .isPicked ==
                                                              false)
                                                      ? pickOrder(
                                                          context, orderModel)
                                                      : (orderModel
                                                                      .isAccepted ==
                                                                  true &&
                                                              orderModel
                                                                      .isPicked ==
                                                                  true &&
                                                              orderModel
                                                                      .isDelivered ==
                                                                  false)
                                                          ? deliverOrder(
                                                              context,
                                                              orderModel)
                                                          : () {};
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  border: Border.all(
                                                    color:
                                                        AppColors.primaryColor,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5),
                                                  )),
                                              child: Center(
                                                child: Text(
                                                  (orderModel.isAccepted ??
                                                              false) ==
                                                          false
                                                      ? 'Accept Order'
                                                      : (orderModel.isAccepted ==
                                                                  true &&
                                                              orderModel
                                                                      .isPicked ==
                                                                  false)
                                                          ? 'Mark As Picked'
                                                          : (orderModel.isAccepted ==
                                                                      true &&
                                                                  orderModel
                                                                          .isPicked ==
                                                                      true &&
                                                                  orderModel
                                                                          .isDelivered ==
                                                                      false)
                                                              ? 'Deliver Order'
                                                              : 'Delivered at: ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(orderModel.deliveredAt!))}',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.blackColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                              "No Order Found!",
                              style: headingSM,
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showLocation(String latitude, String longitude) async {
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open Google Maps.';
    }
  }

  Widget buildDispatcherCard(UserModel dispatcherModel, BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50000),
          child: Image.network(dispatcherModel.image ?? ''),
        ),
        title: Text(
          dispatcherModel.name ?? '',
          style: const TextStyle(
              fontSize: 14,
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          dispatcherModel.phoneno ?? "",
          style: TextStyle(
              fontSize: 12,
              color: AppColors.blackColor.withOpacity(0.6),
              fontWeight: FontWeight.bold),
        ),
        trailing: GestureDetector(
          onTap: () async {
            ChatroomModel? chatroomModel =
                await getChatroomModel(dispatcherModel);
            if (chatroomModel != null) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatRoom(
                      targetUser: dispatcherModel,
                      chatRoom: chatroomModel,
                      userModel: UserModel.loggedinUser!,
                    );
                  },
                ),
              );
            }
          },
          child: Icon(
            Icons.chat_bubble_outline,
            color: AppColors.blackColor,
          ),
        ),
      ),
    );
  }

  Container buildTrackingProductCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(color: AppColors.blackColor.withOpacity(0.2))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth(context) * 0.5,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: screenWidth(context) * 0.65,
                          child: Text(
                            widget.orderModel.orderItems![0]['name'] ?? '',
                            style: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        // Text(
                        //   '${NumberFormat.decimalPattern().format(redeemHistory.points ?? 0)} ${'points'.tr()}',
                        //   style: const TextStyle(
                        //       color: AppColors.blackColor,
                        //       fontSize: 17,
                        //       fontWeight: FontWeight.w500),
                        // ),
                        Text(
                          DateFormat('MMM d, h:mm a').format(
                              DateTime.parse(widget.orderModel.createdAt!)),
                          style: TextStyle(
                              color: AppColors.blackColor.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TrackingStatusWidget extends StatefulWidget {
  final String statusImage;
  final String statusTitle;
  final String statusSubTitle;
  final Color titleColor;
  final Color subTitleColor;
  final Color? imageColor;
  final Widget? verticalDotedLine;
  final Color circleAvatarColor;
  final Function? onTap;

  const TrackingStatusWidget({
    super.key,
    required this.statusImage,
    required this.statusTitle,
    required this.statusSubTitle,
    required this.titleColor,
    required this.subTitleColor,
    this.imageColor,
    this.verticalDotedLine,
    required this.circleAvatarColor,
    this.onTap,
  });

  @override
  State<TrackingStatusWidget> createState() => _TrackingStatusWidgetState();
}

class _TrackingStatusWidgetState extends State<TrackingStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: (widget.onTap == null) ? () {} : widget.onTap!(),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: widget.circleAvatarColor,
                      child: const Icon(
                        Icons.check,
                        color: AppColors.whiteColor,
                        size: 14,
                      ),
                    ),
                    widget.verticalDotedLine ?? Container(),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Image.asset(
                      widget.statusImage,
                      height: 30,
                      color: widget.imageColor ?? null,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.statusTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: widget.titleColor),
                      ),
                      SizedBox(
                        width: screenWidth(context) * 0.6,
                        child: Text(
                          widget.statusSubTitle,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 11,
                            color: widget.subTitleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VerticalDotedLineWidget extends StatelessWidget {
  final Color lineColor;
  const VerticalDotedLineWidget({
    super.key,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(6, (index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              width: 3,
              height: 5,
              decoration: BoxDecoration(
                color: lineColor,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}
