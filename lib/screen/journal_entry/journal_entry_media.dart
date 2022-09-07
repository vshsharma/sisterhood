import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/model/incident_model.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/pre_journal_data.dart';
import 'package:sisterhood_app/screen/Dashboard/journal_history/model/MediaFileModel.dart';
import 'package:sisterhood_app/screen/app_widgets/radio_button_group.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/date_util.dart';
import 'package:sisterhood_app/utill/app_constants.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/strings.dart';
import 'package:sisterhood_app/utill/utils.dart';

import '../../utill/app_paddings.dart';
import '../../utill/sharedprefrence.dart';
import '../../utill/styles.dart';
import '../app_widgets/add_media_button.dart';
import '../app_widgets/checkbox_group.dart';
import '../app_widgets/custom_list_widget.dart';
import '../app_widgets/progress_indicator.dart';
import '../app_widgets/select_media_sheet.dart';
import '../app_widgets/select_media_view.dart';
import '../common/common_card.dart';
import '../common/custom_edit_text.dart';
import '../firebase.dart';

class JournalEntryMedia extends StatefulWidget {
  const JournalEntryMedia();

  @override
  _JournalEntryPagePageState createState() => _JournalEntryPagePageState();
}

class _JournalEntryPagePageState extends State<JournalEntryMedia> {
  IncidentModel _incidentModel = IncidentModel();
  final _formKey = GlobalKey<FormState>();
  var isSelected = false;
  final _auth = FirebaseAuth.instance;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isLoad = false;

  DateTime _targetDateTime = DateTime.now();
  DateTime _calendarSelectedDate = DateTime.now();

  // RequiredData
  List<String> checkedAbuseType = [];
  List<String> checkWhereItHappen = [];
  List<String> checkPartnerUnderInfluence = [];
  List<String> checkIfYouUnderInfluence = [];
  String checkMedicalAssistant = 'No';

  List<PlatformFile> selectedImages = [];
  List<PlatformFile> selectedVideos = [];
  List<PlatformFile> selectedAudio = [];

  List<String> uploadedImages = [];
  List<String> uploadedVideos = [];
  List<String> uploadedAudio = [];
  List<String> uploadedDocuments = [];

  final _whatHappenTextController = TextEditingController();
  final _circumstancesTextConroller = TextEditingController();
  final _areaSpecifyTextController = TextEditingController();
  final _medicalAssistantTextController = TextEditingController();
  final _dateTimeTextController = TextEditingController();

  final _whatHappenTextFocusNode = FocusNode();
  final _areaSpecifyTextFocusNode = FocusNode();
  final _circumstancesTextFocusNode = FocusNode();
  final _medicalAssistantTextFocusNode = FocusNode();
  final _dateTimeTextFocusNode = FocusNode();

  DateTime dateTime = DateTime.now();
  bool isLoading = false;

  void addListener() {
    _whatHappenTextFocusNode.addListener(() => saveDataLocally());
    _areaSpecifyTextFocusNode.addListener(() => saveDataLocally());
    _circumstancesTextFocusNode.addListener(() => saveDataLocally());
    _medicalAssistantTextFocusNode.addListener(() => saveDataLocally());
    _dateTimeTextFocusNode.addListener(() => saveDataLocally());
  }

  @override
  void initState() {
    super.initState();
    addListener();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (SharedPrefManager.sharedPreferences.get(AppConstants.localJournal) ==
              null ||
          SharedPrefManager.sharedPreferences.get(AppConstants.localJournal) ==
              false) {
        SharedPrefManager.sharedPreferences
            .setBool(AppConstants.localJournal, true);
      } else if (SharedPrefManager.sharedPreferences
                  .get(AppConstants.localJournal) !=
              null &&
          SharedPrefManager.sharedPreferences.get(AppConstants.localJournal) ==
              true) {
        setDataFromLocal();
      }
    });
  }

  void showLoader(bool showLoader) {
    setState(() {
      isLoading = showLoader;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BaseWidget(Padding(
          padding: const EdgeInsets.all(dim_20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonCard(Column(
                    children: [
                      const Padding(
                        padding: cardPadding,
                        child: Text(Strings.what_type_of_abuse,
                            style: courierFont18W600ProfilePlaceHolder),
                      ),
                      CheckboxGroup(
                          labels: abuseCategoryList,
                          subLabels: abuseSubCategoryList,
                          showDescription: true,
                          checked: checkedAbuseType,
                          onChange: (bool isChecked, String label, int index) =>
                              print(
                                  "isChecked: $isChecked   label: $label  index: $index"),
                          onSelected: (List<String> checked) {
                            setState(() {
                              checkedAbuseType = checked;
                              saveDataLocally();
                            });
                          }),
                      const SizedBox(
                        height: dim_20,
                      ),
                    ],
                  )),
                  CommonCard(
                    Padding(
                      padding: cardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(Strings.tell_me_what_happend,
                              style: courierFont18W600ProfileHintColor),
                          const SizedBox(
                            height: dim_20,
                          ),
                          CustomEditTextField(
                            _whatHappenTextController,
                            focusNode: _whatHappenTextFocusNode,
                            function: (value) {},
                          ) // explain what happened
                        ],
                      ),
                    ),
                  ), // explain what happened
                  CommonCard(
                    Padding(
                      padding: cardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(Strings.what_were_the_circumstances,
                              style: courierFont18W600ProfileHintColor),
                          const SizedBox(
                            height: dim_20,
                          ),
                          CustomEditTextField(
                            _circumstancesTextConroller,
                            focusNode: _circumstancesTextFocusNode,
                          ),
                        ],
                      ),
                    ),
                  ), //what were the circumstances
                  CommonCard(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: cardPadding,
                        child: Text(Strings.where_did_it_happen,
                            style: courierFont18W600Profile),
                      ),
                      CheckboxGroup(
                        labels: incidentPlace,
                        checked: checkWhereItHappen,
                        onChange: (bool isChecked, String label, int index) =>
                            print(
                                "isChecked: $isChecked   label: $label  index: $index"),
                        onSelected: (List<String> checked) {
                          setState(() {
                            checkWhereItHappen = checked;
                            saveDataLocally();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                  CommonCard(
                    Padding(
                      padding: cardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              Strings.if_outside_or_other_area_please_specify,
                              style: courierFont18W600ProfileHintColor),
                          const SizedBox(
                            height: dim_20,
                          ),
                          CustomEditTextField(
                            _areaSpecifyTextController,
                            focusNode: _areaSpecifyTextFocusNode,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CommonCard(
                    Padding(
                      padding: cardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(Strings.when_did_it_happen,
                              style: courierFont18W600ProfilePlaceHolder),
                          const SizedBox(
                            height: dim_15,
                          ),
                          CalendarCarousel<Event>(
                            todayBorderColor: Colors.black,
                            weekdayTextStyle:
                                const TextStyle(color: ColorResources.black),
                            onDayPressed: (date, events) {
                              this.setState(() => _calendarSelectedDate = date);
                              print('onDayPressed: $date');
                              events.forEach((event) => print(event.title));
                              openDialogToGetIncidentTime(context);
                            },
                            daysHaveCircularBorder: true,
                            showOnlyCurrentMonthDate: true,
                            firstDayOfWeek: 1,
                            weekendTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            weekFormat: false,
                            height: Get.height / 2,
                            selectedDateTime: _calendarSelectedDate,
                            targetDateTime: _targetDateTime,
                            customGridViewPhysics:
                                const NeverScrollableScrollPhysics(),
                            markedDateCustomShapeBorder: const CircleBorder(
                              side: BorderSide(color: Colors.black),
                            ),
                            selectedDayButtonColor:
                                ColorResources.box_background,
                            selectedDayBorderColor: Colors.black,
                            markedDateCustomTextStyle: const TextStyle(
                              fontSize: font_18,
                              color: Colors.black,
                            ),
                            showHeader: true,
                            iconColor: Colors.black,
                            headerTextStyle: arialFont18W600,
                            todayTextStyle:
                                const TextStyle(color: ColorResources.black),
                            todayButtonColor: ColorResources.box_background,
                            selectedDayTextStyle: const TextStyle(
                              color: ColorResources.black,
                            ),
                            minSelectedDate: DateTime.now()
                                .subtract(const Duration(days: 360)),
                            maxSelectedDate:
                                DateTime.now().add(const Duration(days: 360)),
                            onCalendarChanged: (DateTime date) {
                              setState(() {
                                _targetDateTime = date;
                                print('onDayPressed1: $_targetDateTime');
                              });
                            },
                            onDayLongPressed: (DateTime date) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  CommonCard(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: cardPadding,
                          child: Text(
                              Strings.was_your_partner_under_the_influence,
                              style: TextStyle(
                                color: ColorResources.profilePlaceholderColor,
                                fontSize: 18,
                                // letterSpacing: 1,
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        CheckboxGroup(
                            labels: underInfluenceOption,
                            checked: checkPartnerUnderInfluence,
                            onSelected: (List<String> checked) {
                              setState(() {
                                checkPartnerUnderInfluence = checked;
                                saveDataLocally();
                              });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  CommonCard(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: cardPadding,
                          child: Text(Strings.where_you_under_the_influence,
                              style: courierFont18W600ProfilePlaceHolder),
                        ),
                        CheckboxGroup(
                            labels: underInfluenceOption,
                            checked: checkIfYouUnderInfluence,
                            onSelected: (List<String> checked) {
                              setState(() {
                                checkIfYouUnderInfluence = checked;
                                saveDataLocally();
                              });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  CommonCard(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: cardPadding,
                          child: Text(Strings.have_you_seeked_medical_attention,
                              style: courierFont18W600ProfileHintColor),
                        ),
                        RadioButtonGroup(
                            labels: seekedMedicalAttentionOption,
                            picked: checkMedicalAssistant,
                            onSelected: (String selected) {
                              setState(() {
                                checkMedicalAssistant = selected;
                                saveDataLocally();
                              });
                              print(selected);
                              if (selected == "Yes") {
                                medicalAssistantPopUp(context);
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SelectedMediaWidget(
                    widget: Column(
                      children: [
                        AddMediaView(
                          onPress: () async {
                            FilePickerResult result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'png', 'svg', 'jpeg'],
                            );
                            if (result != null) {
                              Utils.log(
                                  "Selected Images length ${result.files.length}");
                              if (result.files.length <
                                  AppConstants.maxImagesSelected) {
                                setState(() {
                                  Utils.log("TAG ${result.files.length}");
                                  selectedImages = result.files;
                                  saveDataLocally();
                                });
                              } else {
                                Utils.log(
                                    "You can select only ${AppConstants.maxImagesSelected} images");
                                Utils.showSnackBar(context,
                                    "You can select only ${AppConstants.maxImagesSelected} images");
                              }
                            } else {
                              Utils.showSnackBar(context, "No file selected");
                            }
                          },
                          icon: Icons.image,
                          label: Strings.add_picture,
                        ),
                        CustomListWidget(selectedImages),
                      ],
                    ),
                  ),
                  SelectedMediaWidget(
                    widget: Column(
                      children: [
                        AddMediaView(
                          onPress: () async {
                            FilePickerResult result = await FilePicker.platform
                                .pickFiles(
                                    allowMultiple: true, type: FileType.video);
                            if (result != null) {
                              print("Tag ${result.files.length}");
                              if (result.files.length <=
                                  AppConstants.maxVideoSelected) {
                                for (var file in result.files) {
                                  if (file.size <
                                      (AppConstants.maxVideoLength *
                                          AppConstants.mbToBytes)) {
                                    selectedVideos.add(file);
                                  } else {
                                    Utils.showSnackBar(context,
                                        "Max size limit for selected video is ${AppConstants.maxVideoLength} MB");
                                  }
                                }
                                setState(() {
                                  saveDataLocally();
                                });
                              } else {
                                Utils.log(
                                    "You can select only ${AppConstants.maxVideoSelected} images");
                                Utils.showSnackBar(context,
                                    "You can select only ${AppConstants.maxVideoSelected} videos");
                              }
                            } else {
                              Utils.showSnackBar(context, "No file selected");
                            }
                          },
                          icon: Icons.video_call,
                          label: Strings.add_video,
                        ),
                        CustomListWidget(selectedVideos),
                      ],
                    ),
                  ),
                  SelectedMediaWidget(
                    widget: Column(
                      children: [
                        AddMediaView(
                          onPress: () async {
                            FilePickerResult result = await FilePicker.platform
                                .pickFiles(
                                    allowMultiple: true, type: FileType.audio);
                            if (result != null) {
                              print("Tag ${result.files.length}");
                              if (result.files.length <=
                                  AppConstants.maxAudioSelected) {
                                for (var file in result.files) {
                                  if (file.size <
                                      (AppConstants.maxAudioLength *
                                          AppConstants.mbToBytes)) {
                                    selectedAudio.add(file);
                                  } else {
                                    Utils.showSnackBar(context,
                                        "Max size limit for selected audio is ${AppConstants.maxAudioLength} MB");
                                  }
                                }
                                setState(() {
                                  saveDataLocally();
                                });
                              } else {
                                Utils.log(
                                    "You can select only ${AppConstants.maxAudioSelected} images");
                                Utils.showSnackBar(context,
                                    "You can select only ${AppConstants.maxAudioSelected} audios");
                              }
                            } else {
                              Utils.showSnackBar(context, "No file selected");
                            }
                          },
                          icon: Icons.audio_file,
                          label: Strings.add_Audio,
                        ),
                        CustomListWidget(selectedAudio),
                      ],
                    ),
                  ),
                  _continueButton()
                ],
              ),
            ),
          ),
        )),
        isLoading ? const ProgressIndicatorWidget() : Stack()
      ],
    );
  }

  Future<dynamic> openDialogToGetIncidentTime(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorResources.background,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(Strings.What_time_did_ithappen,
                    style: courierFont18W600ProfilePlaceHolder),
                const SizedBox(
                  height: dim_10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.box_border,
                      width: dim_1,
                    ),
                    color: ColorResources.box_background,
                    borderRadius: BorderRadius.circular(dim_10),
                  ),
                  height: 70,
                  alignment: Alignment.topCenter,
                  child: InkWell(
                    onTap: () async {
                      showTimerPicker(context, _dateTimeTextController);
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _dateTimeTextController,
                      focusNode: _dateTimeTextFocusNode,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: arialFont14W600,
                      decoration: const InputDecoration(
                        hintText: Strings.write_here,
                        hintStyle: arialFont14W600,
                        errorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Empty";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: dim_30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: dim_25),
                    child: CustomButton(
                        text1: Strings.submit,
                        text2: "",
                        width: Get.width,
                        height: dim_50),
                  ),
                )
              ],
            ),
          );
        });
  }

  void medicalAssistantPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorResources.background,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  Strings.what_medical_facilitydidyouvisit,
                  style: courierFont18W600ProfilePlaceHolder,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.box_border,
                      width: 1,
                    ),
                    color: ColorResources.box_background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    controller: _medicalAssistantTextController,
                    focusNode: _medicalAssistantTextFocusNode,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textAlignVertical: TextAlignVertical.bottom,
                    style: const TextStyle(
                        color: ColorResources.profilehintColor,
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w600),
                    decoration: const InputDecoration(
                      hintText: Strings.write_here,
                      hintStyle: arialFont14W600,
                      errorBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: CustomButton(
                          text1: Strings.submit,
                          text2: "",
                          width: Get.width,
                          height: 50)),
                )
              ],
            ),
          );
        });
  }

  _continueButton() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          showLoader(true);
          await mediaUpload();
          print("Imagages $selectedImages");
          print("Videos $selectedVideos");
          print("Audios $selectedAudio");

          bool isSuccess = await FirebaseRealtimeDataService().saveIncident(
            _calendarSelectedDate,
            prepareRequestBody(),
          );
          Fluttertoast.showToast(
              msg: isSuccess
                  ? "Data submitted successfully"
                  : "Failed to submit dta");
          if (isSuccess) {
            SharedPrefManager.sharedPreferences
                .setBool(AppConstants.localJournal, false);
            Navigator.pop(context);
          }
          showLoader(false);
          // }
        }
      },
      child: CustomButton(
          text1: Strings.submit, text2: "", width: Get.width, height: 60),
    );
  }

  Future<void> mediaUpload() async {
    if (selectedImages.length != null) {
      for (int i = 0; i < selectedImages.length; i++) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('new_journal')
            .child(_auth.currentUser.uid)
            .child(AppConstants.images)
            .child(selectedImages[i].name);
        File fileDoc = File(selectedImages[i].path);
        if (fileDoc != null) {
          await ref.putFile(fileDoc);
          String url = await ref.getDownloadURL();
          uploadedImages.add(url);
          print("Url image $i $url");
        }
      }
    }

    if (selectedVideos.length != null) {
      for (int i = 0; i < selectedVideos.length; i++) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('new_journal')
            .child(_auth.currentUser.uid)
            .child(AppConstants.videos)
            .child(selectedVideos[i].name);
        File fileDoc = File(selectedVideos[i].path);
        if (fileDoc != null) {
          await ref.putFile(fileDoc);
          String url = await ref.getDownloadURL();
          uploadedVideos.add(url);
          print("Url video $i $url");
        }
      }
    }

    if (selectedAudio.length != null) {
      for (int i = 0; i < selectedAudio.length; i++) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('new_journal')
            .child(_auth.currentUser.uid)
            .child(AppConstants.audios)
            .child(selectedAudio[i].name);
        File fileDoc = File(selectedAudio[i].path);
        if (fileDoc != null) {
          await ref.putFile(fileDoc);
          String url = await ref.getDownloadURL();
          uploadedAudio.add(url);
          print("Url audio $i $url");
        }
      }
    }
  }

  String prepareRequestBody() {
    return json.encode({
      'wouldyouliketorecord': json.encode(checkedAbuseType).toString(),
      'whathappend': _whatHappenTextController.text,
      'circumstances': _circumstancesTextConroller.text,
      'happen': json.encode(checkWhereItHappen).toString(),
      'outsideareaspecify': _areaSpecifyTextController.text,
      'datewithhappen': _dateTimeTextController.text,
      'dateStamp': _calendarSelectedDate.toString(),
      'partnerundertheinfluence':
          json.encode(checkPartnerUnderInfluence).toString(),
      'undertheinfluence': json.encode(checkIfYouUnderInfluence).toString(),
      'resultincident': checkMedicalAssistant,
      'popuptext': _medicalAssistantTextController.text,
      'imagesList': json.encode(uploadedImages).toString(),
      'videosList': json.encode(uploadedVideos).toString(),
      'audiosList': json.encode(uploadedAudio).toString()
    });
  }

  showTimerPicker(BuildContext context, TextEditingController _popupcalender) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorResources.background,
            title: const Text('Select Time'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(dim_8),
                  child: TimePickerSpinner(
                    alignment: Alignment.center,
                    is24HourMode: true,
                    normalTextStyle: const TextStyle(
                        fontSize: font_18, color: Colors.black45),
                    highlightedTextStyle:
                        const TextStyle(fontSize: font_22, color: Colors.black),
                    onTimeChange: (time) {
                      setState(() {
                        _popupcalender.text =
                            DateUtil.getDate(_calendarSelectedDate) +
                                ' ' +
                                DateUtil.getTime(time);
                        print('Hello $time');
                      });
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: dim_25),
                    child: CustomButton(
                        text1: Strings.submit,
                        text2: "",
                        width: Get.width,
                        height: dim_50),
                  ),
                )
              ],
            ),
          ); // Time picker close
        });
  }

  selectMediaModelSheet(Function cameraPress, Function galleryPress) {
    showModalBottomSheet(
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: context,
      builder: (BuildContext bc) {
        return SelectMediaSheet(
          cameraPress: cameraPress,
          galleryPress: galleryPress,
        );
      },
    );
  }

  void saveDataLocally() {
    _incidentModel.wouldyouliketorecord =
        json.encode(checkedAbuseType).toString();
    _incidentModel.whathappend = _whatHappenTextController.text;
    _incidentModel.circumstances = _circumstancesTextConroller.text;
    _incidentModel.happen = json.encode(checkWhereItHappen).toString();
    _incidentModel.outsideareaspecify = _areaSpecifyTextController.text;
    _incidentModel.datewithhappen = _dateTimeTextController.text;
    _incidentModel.dateStamp = _calendarSelectedDate.toString();
    _incidentModel.partnerundertheinfluence =
        json.encode(checkPartnerUnderInfluence).toString();
    _incidentModel.undertheinfluence =
        json.encode(checkIfYouUnderInfluence).toString();
    _incidentModel.resultincident = checkMedicalAssistant;
    _incidentModel.popuptext = _medicalAssistantTextController.text;

    var imageslist = getSelectedMedia(selectedImages);
    var videoslist = getSelectedMedia(selectedVideos);
    var audioslist = getSelectedMedia(selectedAudio);
    _incidentModel.imagesList = json.encode(imageslist).toString();
    _incidentModel.videosList = json.encode(videoslist).toString();
    _incidentModel.audiosList = json.encode(audioslist).toString();
    saveDataToPref();
  }

  void saveDataToPref() {
    String incident =
        jsonEncode(IncidentModel.fromJson(_incidentModel.toJson()));
    SharedPrefManager.sharedPreferences
        .setString(AppConstants.journalData, incident);
    print(incident.toString());
  }

  void setDataFromLocal() {
    Map resultData = jsonDecode(SharedPrefManager.sharedPreferences
        .getString(AppConstants.journalData));
    _incidentModel = IncidentModel.fromJson(resultData);
    print(_incidentModel.toJson().toString());
    setState(() {
      if (_incidentModel.wouldyouliketorecord.isNotEmpty) {
        checkedAbuseType =
            json.decode(_incidentModel.wouldyouliketorecord).cast<String>();
      }
      if (_incidentModel.happen.isNotEmpty) {
        checkWhereItHappen = json.decode(_incidentModel.happen).cast<String>();
      }
      if (_incidentModel.partnerundertheinfluence.isNotEmpty) {
        checkPartnerUnderInfluence =
            json.decode(_incidentModel.partnerundertheinfluence).cast<String>();
      }
      if (_incidentModel.undertheinfluence.isNotEmpty) {
        checkIfYouUnderInfluence =
            json.decode(_incidentModel.undertheinfluence).cast<String>();
      }
      if (_incidentModel.resultincident.isNotEmpty) {
        checkMedicalAssistant = _incidentModel.resultincident;
      }
      if (_incidentModel.whathappend.isNotEmpty) {
        _whatHappenTextController.text = _incidentModel.whathappend;
      }
      if (_incidentModel.circumstances.isNotEmpty) {
        _circumstancesTextConroller.text = _incidentModel.circumstances;
      }
      if (_incidentModel.outsideareaspecify.isNotEmpty) {
        _areaSpecifyTextController.text = _incidentModel.outsideareaspecify;
      }
      if (_incidentModel.datewithhappen.isNotEmpty) {
        _dateTimeTextController.text = _incidentModel.datewithhappen;
      }
      if (_incidentModel.popuptext.isNotEmpty) {
        _medicalAssistantTextController.text = _incidentModel.popuptext;
      }
      setSelectedMedia(_incidentModel.imagesList, selectedImages);
      setSelectedMedia(_incidentModel.videosList, selectedVideos);
      setSelectedMedia(_incidentModel.audiosList, selectedAudio);
    });
  }

  void setSelectedMedia(String mediaList, List<PlatformFile> selectedMedia) {
    if (mediaList.isNotEmpty) {
      var listString = json.decode(mediaList).cast<String>();
      for (var mediaFile in listString) {
        MediaFileModel mediaFileModel =
            MediaFileModel.fromJson(jsonDecode(mediaFile));
        selectedMedia.add(PlatformFile(
            size: mediaFileModel.size,
            path: mediaFileModel.path,
            name: mediaFileModel.name));
      }
    }
  }

  List<String> getSelectedMedia(List<PlatformFile> uploadedFiles) {
    List<String> tempList = [];
    for (var platformFiles in uploadedFiles) {
      MediaFileModel mediaFileModel = MediaFileModel(
          path: platformFiles.path,
          name: platformFiles.name,
          size: platformFiles.size);

      String mediaString = jsonEncode(mediaFileModel.toJson());

      tempList.add(mediaString);
    }
    return tempList;
  }
}
