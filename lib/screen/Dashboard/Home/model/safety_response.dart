import '../../../self_help/model/safety_plan_response.dart';

class SafetyResponse {
  String message;
  String code;
  SafetyPlanResponse response;

  SafetyResponse({this.code, this.message, this.response});
}