import '../../routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';

class PayRollScreen extends StatefulWidget {
  const PayRollScreen({super.key});

  @override
  State<PayRollScreen> createState() => _PayRollScreenState();
}

class _PayRollScreenState extends State<PayRollScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primaryColor,
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: Image.asset(AssetsManager.sampleImage),
                              ),
                              widthSizedBox10,
                              Text(
                                "Abdullah khan",
                                style: textThemeData(context)
                                    .headlineSmall!
                                    .copyWith(
                                        color: AppColors.blackColor
                                            .withOpacity(0.5)),
                              )
                            ],
                          ),
                          heightSizedBox10,
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.blackColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Amount to pay',
                                  style: textThemeData(context).headlineSmall,
                                ),
                                Text(
                                  '8,122,00',
                                  style: textThemeData(context).headlineSmall,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
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
                          vertical: 20.0, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '4,000.00',
                                    style: textThemeData(context).headlineSmall,
                                  ),
                                  Text(
                                    'Total Unpaid',
                                    style: textThemeData(context).headlineSmall,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenWidth(context) * 0.2,
                                width: screenWidth(context) * 0.2,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: screenWidth(context) * 0.24,
                                      width: screenWidth(context) * 0.24,
                                      child: const CircularProgressIndicator(
                                        value: 1,
                                        backgroundColor: AppColors.blackColor,
                                        valueColor: AlwaysStoppedAnimation(
                                            AppColors.whiteColor),
                                        strokeWidth: 6.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenWidth(context) * 0.2,
                                      width: screenWidth(context) * 0.2,
                                      child: const CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            AppColors.primaryColor),
                                        backgroundColor: AppColors.blackColor,
                                        value: 1,
                                        strokeWidth: 4.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.transcationHistory);
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      '14,000.00',
                                      style:
                                          textThemeData(context).headlineSmall,
                                    ),
                                    Text(
                                      'Total Paid',
                                      style:
                                          textThemeData(context).headlineSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          heightSizedBox30,
                          Text(
                            'Quick pay',
                            style: textThemeData(context)
                                .headlineSmall!
                                .copyWith(
                                    color: AppColors.greyColor, fontSize: 18),
                          ),
                          heightSizedBox10,
                          Expanded(
                            child: ListView.separated(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.showCalenderScreen);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.backGroundColor,
                                        borderRadius: index == 0
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )
                                            : null,
                                        border: const Border(
                                            bottom: BorderSide(
                                                color: AppColors.greyColor))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                    foregroundColor:
                                                        AppColors.whiteColor,
                                                    backgroundColor:
                                                        AppColors.whiteColor,
                                                  ),
                                                  widthSizedBox10,
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Sir Cumference',
                                                        style: textThemeData(
                                                                context)
                                                            .headlineSmall,
                                                      ),
                                                      Text(
                                                        'Mobile developer',
                                                        style: textThemeData(
                                                                context)
                                                            .headlineSmall!
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .greyColor),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Image.asset(
                                                AssetsManager.arrowIcon,
                                                color: AppColors.primaryColor,
                                                height: 22,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Container();
                              },
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
