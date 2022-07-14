import 'incident_model.dart';

class IncidentResponse {
  String message;
  String code;
  IncidentModel incidentModel;

  IncidentResponse({this.message, this.code, this.incidentModel});
}