
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/edit_journal_entry.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/model/incident_response.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/strings.dart';

import '../../../../utill/styles.dart';
import '../../../firebase.dart';
import '../model/incident_history_response.dart';
import '../model/incident_model.dart';

class JournalHistory extends StatefulWidget {
  const JournalHistory({Key key}) : super(key: key);

  @override
  _JournalHistoryState createState() => _JournalHistoryState();
}

class _JournalHistoryState extends State<JournalHistory> {
  final _formKey = GlobalKey<FormState>();
  CleanCalendarController calendarController;
  ScrollController _scrollController = ScrollController();
  String search = "";


  @override
  void initState() {
    super.initState();
    calendarController = CleanCalendarController(
        minDate: DateTime.now().subtract(const Duration(days: 365)),
        initialDateSelected: DateTime.now(),
        maxDate: DateTime.now(),
        onDayTapped: (date) {
          print('$date');
          fetchFirebseData(date);
        },
        weekdayStart: DateTime.monday,
        rangeMode: false
    );
    WidgetsBinding.instance
        .addPostFrameCallback((_){
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.background,
        appBar: AppBar(
          elevation: dim_0,
          backgroundColor: ColorResources.background,
          leading: Padding(
            padding: const EdgeInsets.only(left: dim_5,top: dim_10),
            child: Column(
              children: [
                InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                      },
                    child: const Icon(Icons.keyboard_arrow_left_outlined,color: ColorResources.grey,size: 35,)),
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap:()=> exit(0),
              child: Padding(
                padding: const EdgeInsets.only(right: dim_10),
                child: Image.asset(Images.loginImage,width: dim_30,height: dim_30,),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: dim_10),
          child: Column(
            children: [
              _searchField(),
              Expanded(
                child: ScrollableCleanCalendar(
                  scrollController: _scrollController,
                  dayBackgroundColor: ColorResources.calenbox,
                  calendarController: calendarController,
                  layout: Layout.DEFAULT,
                  dayRadius: 70,
                  daySelectedBackgroundColor: ColorResources.blue,
                ),
              ),
            ],
          ),
        ),
    );
  }

  _searchField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorResources.box_background,
          borderRadius: BorderRadius.circular(dim_10),
        ),
        height: dim_55,
        alignment: Alignment.topCenter,
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: TextFormField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlignVertical: TextAlignVertical.bottom,
                style: arialFont14W600.copyWith(fontSize: font_18),
                  decoration: InputDecoration(
                  prefixIcon: const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.search, color: ColorResources.grey,size: dim_30,)),
                  hintText: Strings.search,
                  hintStyle: arialFont14W600.copyWith(fontSize: font_16),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void fetchFirebseData(DateTime date) async{
    IncidentResponse incidentResponse = await FirebaseRealtimeDataService().getIncidentData(date);
    print(incidentResponse.code);
    if(incidentResponse.code == '200') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EditJournalEntryPage(incidentResponse.incidentModel)));
    }else {
      Fluttertoast.showToast(
          msg: 'No data found for selected date');
    }
  }
}