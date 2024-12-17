import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:truck_pro/models/order_model.dart';
import 'package:truck_pro/models/user_model.dart';
import 'package:truck_pro/res/helpers/firebase_helper.dart';
import 'package:truck_pro/utilities/app_colors.dart';
import 'package:truck_pro/widgets/custom_appbar.dart';
import '../../models/chats_model.dart';
import '../../res/helpers/get_chatroom.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';
import '../Chats/chatroom.dart';
import 'order_details_controller.dart';

class OrderDetails extends StatefulWidget {
  final OrderModel orderModel;
  const OrderDetails({super.key, required this.orderModel});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  UserModel? driverModel;
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
                                          const SizedBox(height: 5),
                                          buildTrackingProductCard(context),
                                          const SizedBox(height: 15),
                                          (orderModel.isAccepted ?? false)
                                              ? (driverModel == null)
                                                  ? FutureBuilder(
                                                      future: FirebaseHelper
                                                          .getUserModelById(
                                                              orderModel
                                                                  .driverId!),
                                                      builder: (context, snap) {
                                                        if (snap.connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          driverModel =
                                                              snap.data!;
                                                          return buildDriverCard(
                                                              driverModel!,
                                                              context);
                                                        } else {
                                                          return Container();
                                                        }
                                                      })
                                                  : buildDriverCard(
                                                      driverModel!, context)
                                              : Container(),
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
                                          Row(
                                            children: [
                                              Text(
                                                'Status:  ',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                orderModel.trackingStatus!,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Column(
                                            children: [
                                              TrackingStatusWidget(
                                                statusImage: AssetsManager.logo,
                                                statusTitle:
                                                    'Your Order has been placed!',
                                                statusSubTitle:
                                                    'Our driver will contact you shortly!',
                                                titleColor:
                                                    AppColors.blackColor,
                                                subTitleColor:
                                                    AppColors.greyColor,
                                                verticalDotedLine:
                                                    VerticalDotedLineWidget(
                                                  lineColor:
                                                      (orderModel.isActive ??
                                                              false)
                                                          ? Colors.greenAccent
                                                          : AppColors.greyColor,
                                                ),
                                                circleAvatarColor:
                                                    (orderModel.isActive ??
                                                            false)
                                                        ? Colors.greenAccent
                                                        : AppColors.greyColor,
                                              ),
                                              TrackingStatusWidget(
                                                statusImage: AssetsManager.logo,
                                                statusTitle: 'Order Dispatched',
                                                statusSubTitle:
                                                    'Your Order Is On Its Way Deliver Location',
                                                titleColor:
                                                    AppColors.blackColor,
                                                subTitleColor:
                                                    AppColors.greyColor,
                                                imageColor:
                                                    (orderModel.isPicked ??
                                                            false)
                                                        ? null
                                                        : AppColors.greyColor,
                                                verticalDotedLine:
                                                    VerticalDotedLineWidget(
                                                  lineColor:
                                                      (orderModel.isPicked ??
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
                                              TrackingStatusWidget(
                                                statusImage: AssetsManager.logo,
                                                statusTitle: 'Order Delivered',
                                                statusSubTitle:
                                                    'Your Order Has Been Successfully Delivered',
                                                titleColor:
                                                    AppColors.blackColor,
                                                subTitleColor:
                                                    AppColors.greyColor,
                                                imageColor:
                                                    (orderModel.isDelivered ??
                                                            false)
                                                        ? null
                                                        : AppColors.greyColor,
                                                // verticalDotedLine:
                                                //     VerticalDotedLineWidget(
                                                //   lineColor:
                                                //       (orderModel.isDelivered ??
                                                //               false)
                                                //           ? Colors.greenAccent
                                                //           : AppColors.greyColor,
                                                // ),
                                                circleAvatarColor:
                                                    (orderModel.isDelivered ??
                                                            false)
                                                        ? Colors.greenAccent
                                                        : AppColors.greyColor,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors.greyColor
                                                        .withOpacity(0.15),
                                                    spreadRadius: 2,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 1),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      AssetsManager.homeIcon,
                                                      height: 25,
                                                      color: AppColors
                                                          .backGroundColor,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Delivery Address',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            SizedBox(
                                                              width: screenWidth(
                                                                      context) *
                                                                  0.6,
                                                              child: Text(
                                                                orderModel
                                                                        .deliveryLocation ??
                                                                    '',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ((orderModel.isAccepted == true &&
                                                      orderModel.isPicked ==
                                                          false)) ||
                                                  orderModel.isDelivered == true
                                              ? InkWell(
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () {
                                                    (orderModel.isAccepted ==
                                                                true &&
                                                            orderModel
                                                                    .isPicked ==
                                                                false)
                                                        ? showPickUpQrCode(
                                                            context, orderModel)
                                                        : showDeliveryProofDialog(
                                                            context,
                                                            orderModel);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryColor,
                                                        border: Border.all(
                                                          color: AppColors
                                                              .primaryColor,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(5),
                                                        )),
                                                    child: Center(
                                                      child: Text(
                                                        (orderModel.isAccepted ==
                                                                    true &&
                                                                orderModel
                                                                        .isPicked ==
                                                                    false)
                                                            ? 'Mark As Picked'
                                                            : 'Delivered at: ${DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(orderModel.deliveredAt!))}',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .blackColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          const SizedBox(
                                            height: 20,
                                          ),
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

  Widget buildDriverCard(UserModel driverMOdel, BuildContext context) {
    return Card(
      color: AppColors.backGroundColor,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50000),
          child: Image.network(driverMOdel.image ?? ''),
        ),
        title: Text(
          driverMOdel.name ?? '',
          style: const TextStyle(
              fontSize: 14,
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          driverMOdel.phoneno ?? "",
          style: TextStyle(
              fontSize: 12,
              color: AppColors.blackColor.withOpacity(0.6),
              fontWeight: FontWeight.bold),
        ),
        trailing: GestureDetector(
          onTap: () async {
            ChatroomModel? chatroomModel = await getChatroomModel(driverMOdel);
            if (chatroomModel != null) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatRoom(
                      targetUser: driverMOdel,
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
            color: AppColors.primaryColor,
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

  void showPickUpQrCode(BuildContext context, OrderModel orderModel) {
    Future.delayed(const Duration(seconds: 0)).then(
      (value) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: screenHeight(context) * 0.8,
            width: screenWidth(context) * 0.8,
            child: StatefulBuilder(builder: (context, state) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                title: SizedBox(
                  width: screenWidth(context) * 0.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: SizedBox(
                            height: screenWidth(context) * 0.5,
                            width: screenWidth(context) * 0.5,
                            child: generateQR(orderModel.orderId!),
                          ),
                        ),
                      ),
                      Text(
                        "The Driver will scan the Qr Code to start the Order",
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: AppColors.backGroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                actionsPadding: EdgeInsets.zero,
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    border: Border.all(color: Colors.black12)),
                                child: Center(
                                  child: Text(
                                    'Close',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }

  QrImage generateQR(String orderId) {
    return QrImage(
      data: orderId,
      version: QrVersions.auto,
      size: 200.0,
      foregroundColor: AppColors.backGroundColor,
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
  });

  @override
  State<TrackingStatusWidget> createState() => _TrackingStatusWidgetState();
}

class _TrackingStatusWidgetState extends State<TrackingStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
