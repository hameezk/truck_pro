import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../methods/navigate.dart';
import '../../models/order_model.dart';
import '../../models/user_model.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/constants.dart';
import 'order_details.dart';
import 'order_details_driver.dart';

class OrderListile extends StatelessWidget {
  final OrderModel orderModel;

  const OrderListile({
    super.key,
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () => navigate(
            context,
            (UserModel.loggedinUser!.role == 'user')
                ? OrderDetails(orderModel: orderModel)
                : (UserModel.loggedinUser!.role == 'driver')
                    ? OrderDetailsDriver(orderModel: orderModel)
                    : OrderDetails(orderModel: orderModel)),
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
      ),
    );
  }
}
