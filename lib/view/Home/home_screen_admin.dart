import '../../utilities/screen_sizes.dart';
import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
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
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  GridView(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 140,
                                    ),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(0),
                                    children: List.generate(4, (index) {
                                      return Container(
                                        height: 140,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          color: AppColors.backGroundColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    Image.asset(images[index]),
                                              ),
                                            ),
                                            Text(
                                              containerText[index],
                                              textAlign: TextAlign.center,
                                              style: textThemeData(context)
                                                  .headlineSmall!
                                                  .copyWith(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                  heightSizedBox20,
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.backGroundColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Attendence',
                                                style: textThemeData(context)
                                                    .headlineSmall!
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 12,
                                                    ),
                                              ),
                                              Text(
                                                '27 April, 2023',
                                                style: textThemeData(context)
                                                    .headlineSmall!
                                                    .copyWith(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          GridView(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              mainAxisExtent: 60,
                                            ),
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            children: List.generate(6, (index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.blackColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // Text(
                                                    //   containerText[index],
                                                    //   textAlign: TextAlign.center,
                                                    //   style: textThemeData(context)
                                                    //       .headlineSmall!
                                                    //       .copyWith(fontStyle: FontStyle.italic),
                                                    // ),
                                                    Text(
                                                      '34\nPresent',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          textThemeData(context)
                                                              .headlineSmall!
                                                              .copyWith(
                                                                  fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
        ),
      ),
    );
  }
}
