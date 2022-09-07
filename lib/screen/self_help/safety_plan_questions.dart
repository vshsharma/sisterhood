import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/model/safety_response.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/grey_background_widget.dart';
import 'package:sisterhood_app/screen/self_help/model/safety_plan_response.dart';
import 'package:sisterhood_app/utill/app_constants.dart';
import 'package:sisterhood_app/utill/sharedprefrence.dart';
import 'package:sisterhood_app/utill/styles.dart';
import 'package:sisterhood_app/utill/utils.dart';

import '../../utill/custom_button.dart';
import '../../utill/dimension.dart';
import '../../utill/strings.dart';
import '../app_widgets/checkbox_group.dart';
import '../app_widgets/progress_indicator.dart';
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
  bool ctaLabelUpdate = false;
  bool isLoading = false;
  List<String> selectedCheckQuestion = [];
  List<SafetyPlan> saveOnFocus = [];

  String toldInFamily = NO;
  String whereYouFeelSafe = YES;
  String taughtChildren112 = NOTAPPLICBLE;
  String leaveItems = NO;

  TextEditingController whomYouToldCtrlr = TextEditingController();
  TextEditingController placeYouCanGoCtrlr = TextEditingController();
  TextEditingController otherItemsCtrlr = TextEditingController();

  TextEditingController callForHelpCtrlr = TextEditingController();
  TextEditingController emergencyContactCtrlr = TextEditingController();
  TextEditingController comfortablePlaceCtrlr = TextEditingController();
  TextEditingController howWouldYouOutCtrlr = TextEditingController();
  TextEditingController whatWordEventCtrlr = TextEditingController();
  TextEditingController whereYouStoreCtrlr = TextEditingController();

  final _focusNodeCallForHelp = FocusNode();
  final _focusNodeEmergencyContact = FocusNode();
  final _focusNodeComfortablePlace = FocusNode();
  final _focusNodeHowWouldYouOut = FocusNode();
  final _focusNodeWhatWordEvent = FocusNode();
  final _focusNodeWhereYouStore = FocusNode();

  final _focusNodeWhomYouTold = FocusNode();
  final _focusNodePlaceYouCanGo = FocusNode();
  final _focusNodeOtherItems = FocusNode();

  String prepareRequest() {
    return json.encode({
      'question1': json
          .encode(SafetyPlan(
                  count: questionCount[0],
                  question: questionaire[0],
                  option: toldInFamily,
                  description: whomYouToldCtrlr.text)
              .toJson())
          .toString(),
      'question2': json
          .encode(SafetyPlan(
                  count: questionCount[1],
                  question: questionaire[1],
                  option: '',
                  description: callForHelpCtrlr.text)
              .toJson())
          .toString(),
      'question3': json
          .encode(SafetyPlan(
                  count: questionCount[2],
                  question: questionaire[2],
                  option: '',
                  description: emergencyContactCtrlr.text)
              .toJson())
          .toString(),
      'question4': json
          .encode(SafetyPlan(
                  count: questionCount[3],
                  question: questionaire[3],
                  option: '',
                  description: comfortablePlaceCtrlr.text)
              .toJson())
          .toString(),
      'question5': json
          .encode(SafetyPlan(
                  count: questionCount[4],
                  question: questionaire[4],
                  option: '',
                  description: howWouldYouOutCtrlr.text)
              .toJson())
          .toString(),
      'question6': json
          .encode(SafetyPlan(
                  count: questionCount[5],
                  question: questionaire[5],
                  option: whereYouFeelSafe,
                  description: placeYouCanGoCtrlr.text)
              .toJson())
          .toString(),
      'question7': json
          .encode(SafetyPlan(
                  count: questionCount[6],
                  question: questionaire[6],
                  option: taughtChildren112,
                  description: '')
              .toJson())
          .toString(),
      'question8': json
          .encode(SafetyPlan(
                  count: questionCount[7],
                  question: questionaire[7],
                  option: '',
                  description: whatWordEventCtrlr.text)
              .toJson())
          .toString(),
      'question9': json
          .encode(SafetyPlan(
                  count: questionCount[8],
                  question: questionaire[8],
                  option: json.encode(selectedCheckQuestion).toString(),
                  description: '')
              .toJson())
          .toString(),
      'question10': json
          .encode(SafetyPlan(
                  count: questionCount[9],
                  question: questionaire[9],
                  option: leaveItems,
                  description: otherItemsCtrlr.text)
              .toJson())
          .toString(),
      'question11': json
          .encode(SafetyPlan(
                  count: questionCount[10],
                  question: questionaire[10],
                  option: '',
                  description: whereYouStoreCtrlr.text)
              .toJson())
          .toString(),
    });
  }

  Future<void> saveData() async {
    showLoader(true);
    bool isSuccess = await FirebaseRealtimeDataService().saveSafetyPlan(
      prepareRequest(),
    );
    Fluttertoast.showToast(
        msg:
            isSuccess ? "Data submitted successfully" : "Failed to submit dta");
    if (isSuccess) {
      SharedPrefManager.sharedPreferences
          .setBool(AppConstants.isSavedLocal, false);
      SharedPrefManager.sharedPreferences
          .setString(AppConstants.safetyPlan, "");
      Navigator.pop(context);
    }
    showLoader(false);
  }

  Future<void> getSafetyPlan() async {
    showLoader(true);
    SafetyResponse safetyResponse =
        await FirebaseRealtimeDataService().getSafetyPlan();
    SafetyPlanResponse safetyPlanResponse;
    print(safetyResponse.code);
    if (safetyResponse.code == '200') {
      setState(() {
        safetyPlanResponse = safetyResponse.response;
        handleResponseFromFirebase(safetyPlanResponse);
        print(selectedCheckQuestion);
      });
    }
    showLoader(false);
  }

  void handleResponseFromFirebase(SafetyPlanResponse safetyPlanResponse) {
    toldInFamily =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question1)).option;
    whereYouFeelSafe =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question6)).option;
    leaveItems =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question10)).option;
    whomYouToldCtrlr.text =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question1))
            .description;
    callForHelpCtrlr.text =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question2))
            .description;
    emergencyContactCtrlr.text =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question3))
            .description;
    comfortablePlaceCtrlr.text =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question4))
            .description;
    howWouldYouOutCtrlr.text =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question5))
            .description;
    placeYouCanGoCtrlr.text =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question6))
            .description;
    whatWordEventCtrlr.text =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question8))
            .description;
    otherItemsCtrlr.text =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question10))
            .description;
    whereYouStoreCtrlr.text =
        SafetyPlan.fromJson(json.decode(safetyPlanResponse.question11))
            .description;
    selectedCheckQuestion = json
        .decode(SafetyPlan.fromJson(json.decode(safetyPlanResponse.question9))
            .option)
        .cast<String>();
    ctaLabelUpdate = true;
  }

  void showLoader(bool showLoader) {
    setState(() {
      isLoading = showLoader;
    });
  }

  @override
  void initState() {
    super.initState();
    getSafetyPlan();
    addFocusListener();

    if (SharedPrefManager.sharedPreferences
                .getBool(AppConstants.isSavedLocal) !=
            null &&
        SharedPrefManager.sharedPreferences
            .getBool(AppConstants.isSavedLocal)) {
      SafetyPlanResponse safetyPlanResponse = SafetyPlanResponse.fromJson(
          json.decode(SharedPrefManager.sharedPreferences
              .getString(AppConstants.safetyPlan)));
      handleResponseFromFirebase(safetyPlanResponse);
    }
  }

  void addFocusListener() {
    _focusNodeCallForHelp.addListener(() {
      if (_focusNodeCallForHelp.hasFocus) {
        handleFocusListener();
      }
    });

    _focusNodeEmergencyContact.addListener(() {
      if (_focusNodeEmergencyContact.hasFocus) {
        handleFocusListener();
      }
    });
    _focusNodeComfortablePlace.addListener(() {
      if (_focusNodeComfortablePlace.hasFocus) {
        handleFocusListener();
      }
    });
    _focusNodeHowWouldYouOut.addListener(() {
      if (_focusNodeHowWouldYouOut.hasFocus) {
        handleFocusListener();
      }
    });
    _focusNodeWhatWordEvent.addListener(() {
      if (_focusNodeWhatWordEvent.hasFocus) {
        handleFocusListener();
      }
    });
    _focusNodeWhereYouStore.addListener(() {
      if (_focusNodeWhereYouStore.hasFocus) {
        handleFocusListener();
      }
    });

    _focusNodeWhomYouTold.addListener(() {
      if (_focusNodeWhomYouTold.hasFocus) {
        handleFocusListener();
      }
    });

    _focusNodePlaceYouCanGo.addListener(() {
      if (_focusNodePlaceYouCanGo.hasFocus) {
        handleFocusListener();
      }
    });

    _focusNodeOtherItems.addListener(() {
      if (_focusNodeOtherItems.hasFocus) {
        handleFocusListener();
      }
    });
  }

  void handleFocusListener() {
    SharedPrefManager.sharedPreferences
        .setBool(AppConstants.isSavedLocal, true);
    var json = prepareRequest();
    SharedPrefManager.savePrefString(AppConstants.safetyPlan, json);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(isLoading
        ? const ProgressIndicatorWidget()
        : Container(
            child: Padding(
              padding: const EdgeInsets.all(dim_16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GreyBackgroundCard(
                      child: Column(
                        children: [
                          questionHeader(
                              questionNumber: questionCount[0],
                              question: questionaire[0]),
                          RadioButtonGroup(
                              labels: yesNoOption,
                              picked: toldInFamily,
                              onSelected: (String selected) {
                                setState(() {
                                  toldInFamily = selected;
                                  handleFocusListener();
                                });
                                print(selected);
                                if (selected == YES) {
                                  Utils.genericInputPopUp(
                                      context,
                                      Strings.question_1_option_yes,
                                      whomYouToldCtrlr,
                                      _focusNodeWhomYouTold);
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
                              questionNumber: questionCount[1],
                              question: questionaire[1]),
                          Focus(
                            child: CustomEditTextField(
                              callForHelpCtrlr,
                              focusNode: _focusNodeCallForHelp,
                            ),
                            onFocusChange: (hasFocus) {
                              if (hasFocus) {}
                            },
                          ),
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
                              questionNumber: questionCount[2],
                              question: questionaire[2]),
                          CustomEditTextField(
                            emergencyContactCtrlr,
                            focusNode: _focusNodeEmergencyContact,
                          ),
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
                              questionNumber: questionCount[3],
                              question: questionaire[3]),
                          CustomEditTextField(
                            comfortablePlaceCtrlr,
                            focusNode: _focusNodeComfortablePlace,
                          ),
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
                              questionNumber: questionCount[4],
                              question: questionaire[4]),
                          CustomEditTextField(
                            howWouldYouOutCtrlr,
                            focusNode: _focusNodeHowWouldYouOut,
                          ),
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
                              questionNumber: questionCount[5],
                              question: questionaire[5]),
                          RadioButtonGroup(
                              labels: yesNoOption,
                              picked: whereYouFeelSafe,
                              onSelected: (String selected) {
                                setState(() {
                                  whereYouFeelSafe = selected;
                                  handleFocusListener();
                                });
                                print(selected);
                                if (selected == NO) {
                                  Utils.genericInputPopUp(
                                      context,
                                      Strings.question_6_option_no,
                                      placeYouCanGoCtrlr,
                                      _focusNodePlaceYouCanGo);
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
                              questionNumber: questionCount[6],
                              question: questionaire[6]),
                          RadioButtonGroup(
                              labels: yesNoNotApplicbleOption,
                              picked: taughtChildren112,
                              onSelected: (String selected) {
                                setState(() {
                                  taughtChildren112 = selected;
                                  handleFocusListener();
                                });
                                print(selected);
                                if (selected == NO) {
                                  Utils.genericPopUp(
                                      context, Strings.question_7_option_no);
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
                              questionNumber: questionCount[7],
                              question: questionaire[7]),
                          CustomEditTextField(
                            whatWordEventCtrlr,
                            focusNode: _focusNodeWhatWordEvent,
                          ),
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
                              questionNumber: questionCount[8],
                              question: questionaire[8]),
                          CheckboxGroup(
                              labels: questionCheckOption,
                              checked: selectedCheckQuestion,
                              onChange: (bool isChecked, String label,
                                      int index) =>
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
                              questionNumber: questionCount[9],
                              question: questionaire[9]),
                          RadioButtonGroup(
                              labels: yesNoOption,
                              picked: leaveItems,
                              onSelected: (String selected) {
                                setState(() {
                                  leaveItems = selected;
                                  handleFocusListener();
                                });
                                print(selected);
                                if (selected == YES) {
                                  Utils.genericInputPopUp(
                                      context,
                                      Strings.i_will_leave_copies,
                                      otherItemsCtrlr,
                                      _focusNodeOtherItems);
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
                              questionNumber: questionCount[10],
                              question: questionaire[10]),
                          CustomEditTextField(
                            whereYouStoreCtrlr,
                            focusNode: _focusNodeWhereYouStore,
                          ),
                        ],
                      ),
                    ),
                    buildDivider(),
                    InkWell(
                      onTap: saveData,
                      child: CustomButton(
                        text1: ctaLabelUpdate ? Strings.update : Strings.submit,
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
          padding: const EdgeInsets.all(dim_2),
          child: Text(
            'Question $questionNumber',
            style: courierFont18W600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(dim_2),
          child: Text(
            '$question',
            style: courierFont16W600,
          ),
        ),
      ],
    );
  }
}
