import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/extension.dart';

class Questions {
  String getYes(BuildContext context) {
    return context.loc.yes;
  }

  String getNo(BuildContext context) {
    return context.loc.no;
  }

  String getNotApplicable(BuildContext context) {
    return context.loc.not_applicable;
  }

  List<String> getQuestionaire(BuildContext context) {
    return [
      context.loc.safety_question_1,
      context.loc.safety_question_2,
      context.loc.safety_question_3,
      context.loc.safety_question_4,
      context.loc.safety_question_5,
      context.loc.safety_question_6,
      context.loc.safety_question_7,
      context.loc.safety_question_8,
      context.loc.safety_question_9,
      context.loc.safety_question_10,
      context.loc.safety_question_11
    ];
  }

  List<String> getYesNoOption(BuildContext context) {
    return [context.loc.yes, context.loc.no];
  }

  List<String> getYesNoNotApplicableOption(BuildContext context) {
    return [context.loc.yes, context.loc.no, context.loc.not_applicable];
  }

  List<String> getQuestionCheckOption(BuildContext context) {
    return [
      context.loc.check_option_1,
      context.loc.check_option_2,
      context.loc.check_option_3,
      context.loc.check_option_4,
      context.loc.check_option_5,
      context.loc.check_option_6,
      context.loc.check_option_7,
      context.loc.check_option_8,
      context.loc.check_option_9,
      context.loc.check_option_10,
      context.loc.check_option_11,
      context.loc.check_option_12,
      context.loc.check_option_13,
    ];
  }
}

List<String> questionCount = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11'
];
