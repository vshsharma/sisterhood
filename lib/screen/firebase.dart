import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/model/incident_model.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/model/incident_response.dart';

import 'common/date_util.dart';

class FirebaseRealtimeDataService {
  DatabaseReference databaseReference;
  final _auth = FirebaseAuth.instance;
  FirebaseRealtimeDataService() {
    databaseReference = FirebaseDatabase.instance.ref();
  }

  Future<IncidentResponse> getIncidentData(DateTime date) async {
    IncidentResponse incidentResponse;
    String formattedDate = DateUtil.getDate(date);
    final snapshot = await databaseReference
        .child('newjournal')
        .child(_auth.currentUser.uid)
        .child(formattedDate)
        .get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value;
      IncidentModel incidentModel;
      values.forEach((key, value) {
        incidentModel =
            IncidentModel.fromJson(json.decode(value));
      });
      incidentResponse = IncidentResponse(message: "success", code: "200", incidentModel: incidentModel);
    } else {
      print('No data available.');
      incidentResponse = IncidentResponse(message: "failed", code: "400", incidentModel: IncidentModel());
    }
    return incidentResponse;
  }

  Future<bool> saveIncident(DateTime selectedDate, String json) async {
    bool querySaved = false;
    var nodeName = DateUtil.getDate(selectedDate);
    print('Save key: $nodeName');
    await databaseReference
        .child('newjournal')
        .child(_auth.currentUser.uid)
        .child(nodeName)
        .child('data')
        .set(json)
        .then((_)  {
          print("Data saved successfully");
          querySaved = true;
        })
        .catchError((onError) {
      print("Data saved failed");
      querySaved = false;
    });
    return querySaved;
  }

  Future<bool> saveSafetyPlan(String json) async {
    bool querySaved = false;
    var nodeName = DateTime.now().millisecondsSinceEpoch;
    print('Save key: $nodeName');
    await databaseReference
        .child('planSafety')
        .child(_auth.currentUser.uid)
        .child(nodeName.toString())
        .child('data')
        .set(json)
        .then((_)  {
      print("Data saved successfully");
      querySaved = true;
    }).catchError((onError) {
      print("Data saved failed");
      querySaved = false;
    });
    return querySaved;
  }
}
