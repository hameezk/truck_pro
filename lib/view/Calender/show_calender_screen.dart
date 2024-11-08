import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/constants.dart';
import '../../utilities/screen_sizes.dart';
import '../../widgets/custom_text_field.dart';

class ShowCalenderScreen extends StatefulWidget {
  const ShowCalenderScreen({super.key});

  @override
  State<ShowCalenderScreen> createState() => _ShowCalenderScreenState();
}

class _ShowCalenderScreenState extends State<ShowCalenderScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child:
                                        Image.asset(AssetsManager.sampleImage),
                                  ),
                                  widthSizedBox10,
                                  Text(
                                    "Abdullah khan",
                                    style: textThemeData(context)
                                        .headlineSmall!
                                        .copyWith(
                                            color: AppColors.blackColor
                                                .withOpacity(0.5)),
                                  ),
                                ],
                              ),
                              const Icon(Icons.message),
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
                                  'Availabel balance',
                                  style: textThemeData(context).headlineSmall,
                                ),
                                Text(
                                  '+228,122,00',
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextField(
                              hintText: 'Client Management',
                              suffixIcon: Icon(
                                Icons.expand_more,
                                color: AppColors.whiteColor,
                              ),
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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.backGroundColor,
                              ),
                              child: TableCalendar(
                                onDaySelected: (selectedDay, focusedDay) {
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });
                                },
                                selectedDayPredicate: (day) {
                                  return isSameDay(_selectedDay, day);
                                },
                                focusedDay: _focusedDay,
                                firstDay: DateTime.utc(2024, 10, 6),
                                lastDay: DateTime.utc(2070),
                                calendarStyle: const CalendarStyle(
                                  selectedDecoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                  defaultTextStyle: TextStyle(
                                    color: AppColors.whiteColor,
                                  ),
                                  weekendTextStyle: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                daysOfWeekStyle: const DaysOfWeekStyle(
                                  weekdayStyle:
                                      TextStyle(color: AppColors.primaryColor),
                                  weekendStyle:
                                      TextStyle(color: AppColors.primaryColor),
                                ),
                                headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  titleTextStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: AppColors.primaryColor,
                                  ),
                                  leftChevronIcon: Icon(
                                    Icons.chevron_left,
                                    color: AppColors.primaryColor,
                                  ),
                                  rightChevronIcon: Icon(
                                    Icons.chevron_right,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            heightSizedBox20,
                            Container(
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
                                                color: AppColors.primaryColor,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 12,
                                              ),
                                        ),
                                        Text(
                                          '27 April, 2023',
                                          style: textThemeData(context)
                                              .headlineSmall!
                                              .copyWith(
                                                  fontStyle: FontStyle.italic,
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
                                      padding: const EdgeInsets.only(top: 10),
                                      children: List.generate(6, (index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.blackColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
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
                                                textAlign: TextAlign.center,
                                                style: textThemeData(context)
                                                    .headlineSmall!
                                                    .copyWith(fontSize: 12),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
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
