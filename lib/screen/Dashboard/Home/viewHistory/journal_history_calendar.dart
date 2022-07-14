import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimension.dart';

class JournalHistoryCalendar extends StatefulWidget {
  const JournalHistoryCalendar({Key key}) : super(key: key);

  @override
  State<JournalHistoryCalendar> createState() => _JournalHistoryCalendarState();
}

class _JournalHistoryCalendarState extends State<JournalHistoryCalendar> {
  DateTime _calendarSelectedDate = DateTime.now();
  DateTime _targetDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      Center(
        child: CalendarCarousel<Event>(
          todayBorderColor: Colors.black,
          weekdayTextStyle:
          const TextStyle(color: ColorResources.black),
          onDayPressed: (date, events) {
            this.setState(() => _calendarSelectedDate = date);
            print('onDayPressed: $date');
            events.forEach((event) => print(event.title));
          },
          daysHaveCircularBorder: true,
          showOnlyCurrentMonthDate: true,
          firstDayOfWeek: 1,
          weekendTextStyle: const TextStyle(
            color: Colors.black,
          ),
          weekFormat: false,
          height: Get.height / 2,
          selectedDateTime: _calendarSelectedDate,
          targetDateTime: _targetDateTime,
          customGridViewPhysics:
          const NeverScrollableScrollPhysics(),
          markedDateCustomShapeBorder: const CircleBorder(
            side: BorderSide(color: Colors.black),
          ),
          selectedDayButtonColor: ColorResources
              .box_background,
          selectedDayBorderColor: Colors.black,
          markedDateCustomTextStyle: const TextStyle(
            fontSize: font_18,
            color: Colors.black,
          ),
          showHeader: true,
          iconColor: Colors.black,
          headerTextStyle: const TextStyle(
            color: ColorResources.profilePlaceholderColor,
            fontSize: font_18,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
          ),
          todayTextStyle:
          const TextStyle(color: ColorResources.black),
          todayButtonColor: ColorResources.box_background,
          selectedDayTextStyle: const TextStyle(
            color: ColorResources.black,
          ),
          minSelectedDate:
          DateTime.now().subtract(const Duration(days: 360)),
          maxSelectedDate:DateTime.now(),
          onCalendarChanged: (DateTime date) {
            setState(() {
              _targetDateTime = date;
              print('onDayPressed1: $_targetDateTime');
              // _currentMonth =
              //     DateFormat.yMMM().format(_targetDateTime);
            });
          },
          onDayLongPressed: (DateTime date) {},
        ),
      )
    );
  }
}
