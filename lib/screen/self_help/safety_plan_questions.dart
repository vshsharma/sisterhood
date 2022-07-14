import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/grey_background_widget.dart';
import 'package:sisterhood_app/utill/styles.dart';
import 'package:sisterhood_app/utill/utils.dart';

import '../../utill/custom_button.dart';
import '../../utill/dimension.dart';
import '../../utill/strings.dart';
import '../app_widgets/checkbox_group.dart';
import '../app_widgets/radio_button_group.dart';
import '../common/custom_edit_text.dart';
import '../common/question_data.dart';
import '../firebase.dart';
import 'model/request.dart';

class SafetyPlanQuestion extends StatefulWidget {
  const SafetyPlanQuestion({Key key}) : super(key: key);

  @override
  _SafetyPlanQuestionState createState() => _SafetyPlanQuestionState();
}

class _SafetyPlanQuestionState extends State<SafetyPlanQuestion> {
  List<String> selectedCheckQuestion = [];

  String toldInFamily = NO;
  String whereYouFeelSafe = YES;
  String taughtChildren112 = NOTAPPLICBLE;
  String leaveItems = NO;

  TextEditingController whomYouToldCtrlr = TextEditingController();
  TextEditingController placeYouCanGoCtrlr = TextEditingController();
  TextEditingController taughtYourChildrenCtrlr = TextEditingController();
  TextEditingController otherItemsCtrlr = TextEditingController();

  TextEditingController callForHelpCtrlr = TextEditingController();
  TextEditingController emergencyContactCtrlr = TextEditingController();
  TextEditingController comfortablePlaceCtrlr = TextEditingController();
  TextEditingController howWouldYouOutCtrlr = TextEditingController();
  TextEditingController whatWordEventCtrlr = TextEditingController();
  TextEditingController whereYouStoreCtrlr = TextEditingController();

  String prepareRequest() {
    return json.encode({
      'question1': SafetyPlan(count: questionCount[0], question: questionaire[0], option: toldInFamily, description: whomYouToldCtrlr.text).toJson().toString(),
      'question2': SafetyPlan(count: questionCount[1], question: questionaire[1], option: '', description: callForHelpCtrlr.text).toJson().toString(),
      'question3': SafetyPlan(count: questionCount[2], question: questionaire[2], option: '', description: emergencyContactCtrlr.text).toJson().toString(),
      'question4': SafetyPlan(count: questionCount[3], question: questionaire[3], option: '', description: comfortablePlaceCtrlr.text).toJson().toString(),
      'question5': SafetyPlan(count: questionCount[4], question: questionaire[4], option: '', description: howWouldYouOutCtrlr.text).toJson().toString(),
      'question6': SafetyPlan(count: questionCount[5], question: questionaire[5], option: whereYouFeelSafe, description: placeYouCanGoCtrlr.text).toJson().toString(),
      'question7': SafetyPlan(count: questionCount[6], question: questionaire[6], option: taughtChildren112, description: taughtYourChildrenCtrlr.text).toJson().toString(),
      'question8': SafetyPlan(count: questionCount[7], question: questionaire[7], option: '', description: whatWordEventCtrlr.text).toJson().toString(),
      'question9':  SafetyPlan(count: questionCount[8], question: questionaire[8], option: json.encode(selectedCheckQuestion).toString(), description: '').toJson().toString(),
      'question10': SafetyPlan(count: questionCount[9], question: questionaire[9], option: leaveItems, description: otherItemsCtrlr.text).toJson().toString(),
      'question11': SafetyPlan(count: questionCount[10], question: questionaire[10], option: '', description: whereYouStoreCtrlr.text).toJson().toString(),
    });
  }

  saveData() async {
    bool isSuccess = await FirebaseRealtimeDataService().saveSafetyPlan(
      prepareRequest(),
    );
    Fluttertoast.showToast(
        msg: isSuccess
            ? "Data submitted successfully"
            : "Failed to submit dta");
    if (isSuccess) {
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return BaseWidget(Container(
      child: Padding(
        padding: const EdgeInsets.all(dim_16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GreyBackgroundCard(
                child: Column(
                  children: [
                    questionHeader(
                        questionNumber: questionCount[0], question: questionaire[0]),
                    RadioButtonGroup(
                        labels: yesNoOption,
                        picked: toldInFamily,
                        onSelected: (String selected) {
                          setState(() {
                            toldInFamily = selected;
                          });
                          print(selected);
                          if (selected == YES) {
                            Utils.genericInputPopUp(context, Strings.question_1_option_yes, whomYouToldCtrlr);
                          }
                        }),
                  ],
                ),
              ),
              buildDivider(),
              GreyBackgroundCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionHeader(
                        questionNumber: questionCount[1], question: questionaire[1]),
                    CustomEditTextField(callForHelpCtrlr),
                  ],
                ),
              ),
              buildDivider(),
              GreyBackgroundCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionHeader(
                        questionNumber: questionCount[2], question: questionaire[2]),
                    CustomEditTextField(emergencyContactCtrlr),
                  ],
                ),
              ),
              buildDivider(),
              GreyBackgroundCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionHeader(
                        questionNumber: questionCount[3], question: questionaire[3]),
                    CustomEditTextField(comfortablePlaceCtrlr),
                  ],
                ),
              ),
              buildDivider(),
              GreyBackgroundCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionHeader(
                        questionNumber: questionCount[4], question: questionaire[4]),
                    CustomEditTextField(howWouldYouOutCtrlr),
                  ],
                ),
              ),
              buildDivider(),
              GreyBackgroundCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionHeader(
                        questionNumber: questionCount[5], question: questionaire[5]),
                    RadioButtonGroup(
                        labels: yesNoOption,
                        picked: whereYouFeelSafe,
                        onSelected: (String selected) {
                          setState(() {
                            whereYouFeelSafe = selected;
                          });
                          print(selected);
                          if (selected == NO) {
                            Utils.genericInputPopUp(context, Strings.question_6_option_no, placeYouCanGoCtrlr);
                          }
                        }),
                  ],
                ),
              ),
              buildDivider(),
              GreyBackgroundCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionHeader(
                        questionNumber: questionCount[6], question: questionaire[6]),
                    RadioButtonGroup(
                        labels: yesNoNotApplicbleOption,
                        picked: taughtChildren112,
                        onSelected: (String selected) {
                          setState(() {
                            taughtChildren112 = selected;
                          });
                          print(selected);
                          if (selected == NO) {
                            Utils.genericInputPopUp(context, Strings.question_7_option_no, taughtYourChildrenCtrlr);
                          }
                        }),
                  ],
                ),
              ),
              buildDivider(),
              GreyBackgroundCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionHeader(
                        questionNumber: questionCount[7], question: questionaire[7]),
                    CustomEditTextField(whatWordEventCtrlr),
                  ],
                ),
              ),
              buildDivider(),
              GreyBackgroundCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionHeader(
                        questionNumber: questionCount[8], question: questionaire[8]),
                    CheckboxGroup(
                        labels: questionCheckOption,
                        checked: selectedCheckQuestion,
                        onChange: (bool isChecked, String label, int index) =>
                            print(
                                "isChecked: $isChecked   label: $label  index: $index"),
                        onSelected: (List<String> checked) {
                          setState(() {
                            selectedCheckQuestion = checked;
                          });
                        }),
                  ],
                ),
              ),
              buildDivider(),
              GreyBackgroundCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionHeader(
                        questionNumber: questionCount[9], question: questionaire[9]),
                    RadioButtonGroup(
                        labels: yesNoOption,
                        picked: leaveItems,
                        onSelected: (String selected) {
                          setState(() {
                            leaveItems = selected;
                          });
                          print(selected);
                          if (selected == YES) {
                            otherItemsCtrlr.text = Strings.i_will_leave_copies;
                            Utils.genericInputPopUpNoTitle(context, otherItemsCtrlr);
                          }
                        }),
                  ],
                ),
              ),
              buildDivider(),
              GreyBackgroundCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionHeader(
                        questionNumber: questionCount[10], question: questionaire[10]),
                    CustomEditTextField(whereYouStoreCtrlr),
                  ],
                ),
              ),
              buildDivider(),
              InkWell(
                onTap: saveData,
                child: CustomButton(
                  text1: Strings.submit,
                  text2: '',
                  width: Get.width,
                  height: dim_50,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: dim_10, horizontal: dim_60),
      child: Divider(
                color: Colors.transparent,
                height: dim_2,
                thickness: dim_1,
              ),
    );
  }

  Column questionHeader({questionNumber: '', question: ''}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(dim_2),
          child: Text(
            'Question $questionNumber',
            style: courierFont18W600,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(dim_2),
          child: Text(
            '$question',
            style: courierFont16W600,
          ),
        ),
      ],
    );
  }
}
