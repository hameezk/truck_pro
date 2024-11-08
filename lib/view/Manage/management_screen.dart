import '../../res/providers/expanding_container_provider.dart';
import '../../widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
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
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Image.asset(AssetsManager.sampleImage),
                        ),
                        heightSizedBox10,
                        Text(
                          'Welcome back!',
                          style: textThemeData(context)
                              .headlineSmall!
                              .copyWith(color: AppColors.blackColor),
                        ),
                        Text(
                          "Abdullah khan",
                          style: textThemeData(context).headlineSmall!.copyWith(
                              color: AppColors.blackColor.withOpacity(0.5)),
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
                          vertical: 20.0, horizontal: 20),
                      child: Column(
                        children: [
                          const CustomTextField(
                            hintText: 'Client Management',
                            suffixIcon: Icon(
                              Icons.expand_more,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          heightSizedBox10,
                          const CustomTextField(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                          ),
                          heightSizedBox10,
                          Expanded(
                            child: Consumer<AttendanceContainerProvider>(
                                builder: (context, expand, child) {
                              return ListView.builder(
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          for (int i = 0; i <= 9; i++) {
                                            if (i == index) {
                                              expand.setContainerState(index);
                                            } else {
                                              if (expand.isExpanded(i)) {
                                                expand.setContainerState(i);
                                              }
                                            }
                                          }
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeInOut,
                                          decoration: BoxDecoration(
                                            color: AppColors.backGroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          foregroundColor:
                                                              AppColors
                                                                  .whiteColor,
                                                          backgroundColor:
                                                              AppColors
                                                                  .whiteColor,
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
                                                                      fontSize:
                                                                          12,
                                                                      color: AppColors
                                                                          .greyColor),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    expand.isExpanded(index)
                                                        ? const Icon(
                                                            Icons.message,
                                                            color: AppColors
                                                                .whiteColor)
                                                        : Text(
                                                            'Approved',
                                                            style: textThemeData(
                                                                    context)
                                                                .headlineSmall!
                                                                .copyWith(
                                                                  fontSize: 11,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                          ),
                                                  ],
                                                ),
                                                heightSizedBox10,
                                                AnimatedSize(
                                                  duration: const Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.easeInOut,
                                                  child:
                                                      expand.isExpanded(index)
                                                          ? Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                GridView(
                                                                  gridDelegate:
                                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount:
                                                                        3,
                                                                    mainAxisSpacing:
                                                                        10,
                                                                    childAspectRatio:
                                                                        1.5,
                                                                    crossAxisSpacing:
                                                                        15,
                                                                  ),
                                                                  shrinkWrap:
                                                                      true,
                                                                  children: List
                                                                      .generate(
                                                                          3,
                                                                          (index) {
                                                                    return const TimeInTimeOutContainer();
                                                                  }),
                                                                ),
                                                                heightSizedBox20,
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              screenWidth(context) * 0.2,
                                                                          width:
                                                                              screenWidth(context) * 0.2,
                                                                          child:
                                                                              const CircularProgressIndicator(
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                            backgroundColor:
                                                                                AppColors.whiteColor,
                                                                            value:
                                                                                0.7,
                                                                          ),
                                                                        ),
                                                                        widthSizedBox10,
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              '33m 34s',
                                                                              style: textThemeData(context).headlineSmall!.copyWith(fontSize: 11),
                                                                            ),
                                                                            Text(
                                                                              '12 Hours',
                                                                              style: textThemeData(context).headlineSmall!.copyWith(fontSize: 10, color: AppColors.greyColor),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      'Approved',
                                                                      style: textThemeData(
                                                                              context)
                                                                          .headlineSmall!
                                                                          .copyWith(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
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

class TimeInTimeOutContainer extends StatelessWidget {
  const TimeInTimeOutContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.whiteColor.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Date',
            style: textThemeData(context).headlineSmall!.copyWith(fontSize: 12),
          ),
          Text(
            '1 Oct 2024',
            style: textThemeData(context)
                .headlineSmall!
                .copyWith(color: AppColors.greyColor, fontSize: 11),
          )
        ],
      ),
    );
  }
}
