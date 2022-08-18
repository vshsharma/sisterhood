import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/model/incident_model.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/model/incident_response.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/model/safety_response.dart';
import 'package:sisterhood_app/screen/self_help/model/safety_plan_response.dart';

import 'Dashboard/Home/model/incident_history_response.dart';
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
        incidentModel = IncidentModel.fromJson(json.decode(value));
      });
      incidentResponse = IncidentResponse(
          message: "success", code: "200", incidentModel: incidentModel);
    } else {
      print('No data available.');
      incidentResponse = IncidentResponse(
          message: "failed", code: "400", incidentModel: IncidentModel());
    }
    return incidentResponse;
  }

  Future<IncidentHistoryResponse> getIncidentHistory() async {
    List<IncidentModel> incidentList = [];
    IncidentHistoryResponse incidentHistoryResponse;
    final snapshot = await databaseReference
        .child('newjournal')
        .child(_auth.currentUser.uid)
        .get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value;
      IncidentModel incidentModel;
      values.forEach((key, value) {
        incidentModel = IncidentModel.fromJson(json.decode(value["data"]));
        incidentModel.key = key.toString();
        incidentList.add(incidentModel);
      });
      incidentHistoryResponse = IncidentHistoryResponse(
          message: "success", code: "200", incidentList: incidentList);
    } else {
      print('No data available.');
      incidentHistoryResponse = IncidentHistoryResponse(
          message: "failed", code: "400", incidentList: incidentList);
    }
    return incidentHistoryResponse;
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
        .then((_) {
      print("Data saved successfully");
      querySaved = true;
    }).catchError((onError) {
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
        .child('data')
        .set(json)
        .then((_) {
      print("Data saved successfully");
      querySaved = true;
    }).catchError((onError) {
      print("Data saved failed");
      querySaved = false;
    });
    return querySaved;
  }

  Future<SafetyResponse> getSafetyPlan() async {
    final snapshot = await databaseReference
        .child('planSafety')
        .child(_auth.currentUser.uid)
        .get();
    SafetyResponse safetyResponse;
    SafetyPlanResponse safetyPlanResponse;
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value;
      print("${json.decode(values["data"])}");
      safetyPlanResponse =
          SafetyPlanResponse.fromJson(json.decode(values["data"]));
      safetyResponse = SafetyResponse(
          code: "200", message: "success", response: safetyPlanResponse);
    } else {
      print('No data available.');
      safetyResponse = SafetyResponse(
          message: "failed", code: "400", response: SafetyPlanResponse());
    }
    return safetyResponse;
  }

  Future<String> getContactUsLink() async {
    String response = "error";
    final docRef =
        FirebaseFirestore.instance.collection('contactus').doc("url");

    await docRef.get().then((DocumentSnapshot doc) {
      final result = doc.data() as Map<String, dynamic>;
      response = result['doclink'];
    }, onError: (e) {
      response = e.toString();
    });
    return response;
  }
}
