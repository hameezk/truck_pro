import 'package:flutter/material.dart';
import 'package:truck_pro/utilities/app_colors.dart';
import 'package:truck_pro/view/Orders/create_order_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_field.dart';
import 'google_map_widget.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  bool showDeleteIcon = false;
  @override
  void initState() {
    initOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              showBackButton: true,
              title: "Create Orders",
              backGroundColor: AppColors.backGroundColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: screenWidth(context) * 0.09,
                                        child: Text(
                                          'Qty',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth(context) * 0.4,
                                        child: Text(
                                          'Name',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: AppColors.blackColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: screenWidth(context) * 0.1,
                                    child: Text(
                                      'Price',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ),
                                  (showDeleteIcon)
                                      ? SizedBox(
                                          width: screenWidth(context) * 0.16,
                                          child: Text(
                                            'delete',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              ordersList.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Please Add Some Items',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.blackColor),
                                          ),
                                          SizedBox(height: 10),
                                          GestureDetector(
                                              onTap: () {
                                                getImageFromCamera(
                                                    context, mounted, setState);
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: AppColors.blackColor,
                                              )),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: ordersList.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onLongPress: () {
                                              setState(() {
                                                showDeleteIcon = false;
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: screenWidth(
                                                                context) *
                                                            0.1,
                                                        child: Text(
                                                          ordersList[index]
                                                                  ['qty']
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth(
                                                                context) *
                                                            0.4,
                                                        child: Text(
                                                          ordersList[index]
                                                                  ['name'] ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        screenWidth(context) *
                                                            0.15,
                                                    child: Text(
                                                      ordersList[index]['price']
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  showDeleteIcon
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            deleteOrderItem(
                                                                index);
                                                            setState(() {
                                                              showDeleteIcon =
                                                                  false;
                                                            });
                                                          },
                                                          child: SizedBox(
                                                            width: screenWidth(
                                                                    context) *
                                                                0.15,
                                                            child: Icon(
                                                              Icons.delete,
                                                              size: 18,
                                                              color: AppColors
                                                                  .blackColor,
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Full Name',
                        style: headingSM,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Enter your full name',
                        readOnly: true,
                        controller: nameController,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Email',
                        style: headingSM,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Enter your email',
                        readOnly: true,
                        controller: emailController,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Phone No.',
                        style: headingSM,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Enter your Phone No.',
                        controller: phonenoController,
                        readOnly: true,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Pickup Locatiion',
                        style: headingSM,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Enter pickup location',
                        controller: pickupLocation,
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              showAddNewAddressBottomSheet(context, true),
                          child: Icon(
                            Icons.attachment,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Delivery Locatiion',
                        style: headingSM,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Enter delivery location',
                        controller: deliveryLocation,
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              showAddNewAddressBottomSheet(context, false),
                          child: Icon(
                            Icons.attachment,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          checkValues(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1.0,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              )),
                          child: Center(
                            child: Text(
                              'Create Order',
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
              ),
            )
          ],
        ),
      ),
    );
  }

  void showAddNewAddressBottomSheet(BuildContext context, bool isPickup) {
    showModalBottomSheet<dynamic>(
      context: context,
      useRootNavigator: true,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      builder: (BuildContext bc) {
        return Container(
          color: AppColors.backGroundColor,
          height: MediaQuery.of(bc).size.height * 0.85,
          child: Column(
            children: [
              StatefulBuilder(builder: (context, set) {
                return SizedBox(
                    height: MediaQuery.of(bc).size.height * 0.85,
                    child: GoogleMapWidget(
                      isPickup: isPickup,
                      createOrderState: setState,
                    ));
              }),
            ],
          ),
        );
      },
    );
  }
}
