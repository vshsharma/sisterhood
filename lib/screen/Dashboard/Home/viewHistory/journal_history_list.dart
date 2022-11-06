import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sisterhood_app/screen/Dashboard/journal_history/edit_journal_entry_media.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/date_util.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/styles.dart';

import '../../../app_widgets/progress_indicator.dart';
import '../../../firebase.dart';
import '../model/incident_history_response.dart';
import '../model/incident_model.dart';

class JournalHistoryList extends StatefulWidget {
  const JournalHistoryList({Key key}) : super(key: key);

  @override
  State<JournalHistoryList> createState() => _JournalHistoryListState();
}

class _JournalHistoryListState extends State<JournalHistoryList> {
  List<IncidentModel> incidentList = [];
  bool isShowLoader = false;

  void showLoader(bool showLoader) {
    setState(() {
      isShowLoader = showLoader;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHistoryData();
  }

  Future<void> fetchHistoryData() async {
    showLoader(true);
    IncidentHistoryResponse incidentHistoryResponse =
        await FirebaseRealtimeDataService().getIncidentHistory();
    print(incidentHistoryResponse.code);
    if (incidentHistoryResponse.code == '200') {
      incidentList = incidentHistoryResponse.incidentList;
      setState(() {
        incidentList
            .sort((obj1, obj2) => obj2.dateTime.compareTo(obj1.dateTime));
      });
    } else {
      Fluttertoast.showToast(msg: AppLocalizations.of(context).no_data_found);
    }
    showLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(isShowLoader
        ? const ProgressIndicatorWidget()
        : Center(
            child: ListView.builder(
                itemCount: incidentList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                EditJournalEntryMediaPage(incidentList[index]),
                          ),
                        );
                      },
                      leading: const Icon(Icons.list),
                      title: Text(
                          DateUtil.getStringFormattedDate(
                              incidentList[index].key),
                          style: courierFont20W600),
                      subtitle: Text(
                        AppLocalizations.of(context).logged,
                        style: courierFont16W600,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(dim_10),
                    ),
                    elevation: dim_5,
                    margin: const EdgeInsets.all(dim_5),
                  );
                }),
          ));
  }
}
