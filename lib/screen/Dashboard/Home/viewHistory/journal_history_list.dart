import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/date_util.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/strings.dart';
import 'package:sisterhood_app/utill/styles.dart';

import '../../../firebase.dart';
import '../edit_journal_entry.dart';
import '../model/incident_history_response.dart';
import '../model/incident_model.dart';

class JournalHistoryList extends StatefulWidget {
  const JournalHistoryList({Key key}) : super(key: key);

  @override
  State<JournalHistoryList> createState() => _JournalHistoryListState();
}

class _JournalHistoryListState extends State<JournalHistoryList> {
  List<IncidentModel> incidentList = [];
  @override
  void initState() {
    super.initState();
    fetchHistoryData();
  }

  Future<void> fetchHistoryData() async {
    IncidentHistoryResponse incidentHistoryResponse =
        await FirebaseRealtimeDataService().getIncidentHistory();
    print(incidentHistoryResponse.code);
    if (incidentHistoryResponse.code == '200') {
      setState(() {
        incidentList = incidentHistoryResponse.incidentList;
      });

    } else {
      Fluttertoast.showToast(msg: 'No data found for selected date');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(Center(
      child: ListView.builder(
          itemCount: incidentList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => EditJournalEntryPage(incidentList[index])));
                },
                leading: const Icon(Icons.list),
                title: Text(DateUtil.getFormattedDate(incidentList[index].key),
                    style: courierFont20W600),
                subtitle: const Text(
                  Strings.LOGGED,
                  style: courierFont16W600,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(dim_10),
              ),
              elevation: dim_5,
              margin: EdgeInsets.all(dim_5),
            );
          }),
    ));
  }
}
