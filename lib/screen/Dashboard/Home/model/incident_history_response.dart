import 'incident_model.dart';

class IncidentHistoryResponse {
  String message;
  String code;
  List<IncidentModel> incidentList;

  IncidentHistoryResponse({this.message, this.code, this.incidentList});
}