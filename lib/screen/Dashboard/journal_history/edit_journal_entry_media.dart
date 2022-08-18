import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filesize/filesize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/model/incident_model.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/pre_journal_data.dart';
import 'package:sisterhood_app/screen/Dashboard/journal_history/model/MediaFileModel.dart';
import 'package:sisterhood_app/screen/app_widgets/radio_button_group.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/date_util.dart';
import 'package:sisterhood_app/utill/app_paddings.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/strings.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/styles.dart';
import '../../../utill/utils.dart';
import '../../app_widgets/add_media_button.dart';
import '../../app_widgets/checkbox_group.dart';
import '../../app_widgets/progress_indicator.dart';
import '../../app_widgets/select_media_view.dart';
import '../../common/common_card.dart';
import '../../common/custom_edit_text.dart';
import '../../firebase.dart';

class EditJournalEntryMediaPage extends StatefulWidget {
  final IncidentModel _incidentModel;

  const EditJournalEntryMediaPage(this._incidentModel);

  @override
  _EditJournalEntryMediaPagePageState createState() =>
      _EditJournalEntryMediaPagePageState();
}

class _EditJournalEntryMediaPagePageState
    extends State<EditJournalEntryMediaPage> {
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
  // Local files list
  List<PlatformFile> selectedImages = [];
  List<PlatformFile> selectedVideos = [];
  List<PlatformFile> selectedAudio = [];
  List<XFile> selectedDocuments = [];

  // Uploaded files list
  List<MediaFileModel> uploadedImages = [];
  List<MediaFileModel> uploadedVideos = [];
  List<MediaFileModel> uploadedAudio = [];
  List<MediaFileModel> uploadedDocuments = [];

  final _whatHappenTextController = TextEditingController();
  final _circumstancesTextConroller = TextEditingController();
  final _areaSpecifyTextController = TextEditingController();
  final _medicalAssistantTextController = TextEditingController();
  final _dateTimeTextController = TextEditingController();

  DateTime dateTime = DateTime.now();
  bool isLoading = false;

  void showLoader(bool showLoader) {
    setState(() {
      isLoading = showLoader;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget._incidentModel.imagesList.isNotEmpty) {
      var images = json.decode(widget._incidentModel.imagesList).cast<String>();
      for (var obj in images) {
        uploadedImages.add(MediaFileModel(url: obj, upload: false, name: obj));
      }
    }
    if (widget._incidentModel.videosList.isNotEmpty) {
      var videos = json.decode(widget._incidentModel.videosList).cast<String>();
      for (var obj in videos) {
        uploadedVideos.add(MediaFileModel(url: obj, upload: false, name: obj));
      }
    }
    if (widget._incidentModel.audiosList.isNotEmpty) {
      var audio = json.decode(widget._incidentModel.audiosList).cast<String>();
      for (var obj in audio) {
        uploadedAudio.add(MediaFileModel(url: obj, upload: false, name: obj));
      }
    }
    if (widget._incidentModel.wouldyouliketorecord.isNotEmpty) {
      checkedAbuseType = json
          .decode(widget._incidentModel.wouldyouliketorecord)
          .cast<String>();
    }
    if (widget._incidentModel.happen.isNotEmpty) {
      checkWhereItHappen =
          json.decode(widget._incidentModel.happen).cast<String>();
    }
    if (widget._incidentModel.partnerundertheinfluence.isNotEmpty) {
      checkPartnerUnderInfluence = json
          .decode(widget._incidentModel.partnerundertheinfluence)
          .cast<String>();
    }
    if (widget._incidentModel.undertheinfluence.isNotEmpty) {
      checkIfYouUnderInfluence =
          json.decode(widget._incidentModel.undertheinfluence).cast<String>();
    }
    if (widget._incidentModel.resultincident.isNotEmpty) {
      checkMedicalAssistant = widget._incidentModel.resultincident;
    }
    if (widget._incidentModel.whathappend.isNotEmpty) {
      _whatHappenTextController.text = widget._incidentModel.whathappend;
    }
    if (widget._incidentModel.circumstances.isNotEmpty) {
      _circumstancesTextConroller.text = widget._incidentModel.circumstances;
    }
    if (widget._incidentModel.outsideareaspecify.isNotEmpty) {
      _areaSpecifyTextController.text =
          widget._incidentModel.outsideareaspecify;
    }
    if (widget._incidentModel.datewithhappen.isNotEmpty) {
      _dateTimeTextController.text = widget._incidentModel.datewithhappen;
    }
    if (widget._incidentModel.popuptext.isNotEmpty) {
      _medicalAssistantTextController.text = widget._incidentModel.popuptext;
    }
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
                            style: TextStyle(
                              color: ColorResources.profilePlaceholderColor,
                              fontSize: font_18,
                              fontFamily: 'Courier',
                              fontWeight: FontWeight.w600,
                            )),
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
                          CustomEditTextField(_whatHappenTextController)
                          // explain what happened
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
                          CustomEditTextField(_circumstancesTextConroller),
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
                          CustomEditTextField(_areaSpecifyTextController),
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
                            headerTextStyle: const TextStyle(
                              color: ColorResources.profilePlaceholderColor,
                              fontSize: font_18,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold,
                            ),
                            todayTextStyle:
                                const TextStyle(color: ColorResources.black),
                            todayButtonColor: ColorResources.box_background,
                            selectedDayTextStyle: const TextStyle(
                              color: ColorResources.black,
                            ),
                            minSelectedDate:
                                DateTime.now().subtract(Duration(days: 360)),
                            maxSelectedDate:
                                DateTime.now().add(const Duration(days: 360)),
                            onCalendarChanged: (DateTime date) {
                              setState(() {
                                _targetDateTime = date;
                                print('onDayPressed1: $_targetDateTime');
                                // _currentMonth =
                                //     DateFormat.yMMM().format(_targetDateTime);
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
                              });
                            }),
                        SizedBox(
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
                              if ((uploadedImages.length +
                                      result.files.length) <
                                  AppConstants.maxImagesSelected) {
                                setState(() {
                                  Utils.log("TAG ${result.files.length}");
                                  selectedImages = result.files;
                                  for (var platFormObj in selectedImages) {
                                    uploadedImages.add(MediaFileModel(
                                        url: "",
                                        size: platFormObj.size,
                                        upload: true,
                                        name: platFormObj.name,
                                        path: platFormObj.path));
                                  }
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
                        ListView.builder(
                          itemCount: uploadedImages.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      uploadedImages[index].name,
                                      maxLines: 1,
                                      style: courierFont14W600ProfileHintColor,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      filesize(uploadedImages[index].size),
                                      style: courierFont12W600ProfileHintColor,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Container(
                                width: dim_100,
                                height: dim_1,
                                color: ColorResources.black,
                              ),
                            );
                          },
                        ),
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
                              if ((uploadedVideos.length +
                                      result.files.length) <=
                                  AppConstants.maxVideoSelected) {
                                for (var file in result.files) {
                                  if (file.size <
                                      (AppConstants.maxVideoLength *
                                          AppConstants.mbToBytes)) {
                                    selectedVideos.add(file);
                                    for (var platFormObj in selectedVideos) {
                                      uploadedVideos.add(MediaFileModel(
                                          url: "",
                                          size: platFormObj.size,
                                          upload: true,
                                          name: platFormObj.name,
                                          path: platFormObj.path));
                                    }
                                  } else {
                                    Utils.showSnackBar(context,
                                        "Max size limit for selected video is ${AppConstants.maxVideoLength} MB");
                                  }
                                }
                                setState(() {});
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
                        ListView.builder(
                          itemCount: uploadedVideos.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      uploadedVideos[index].name,
                                      maxLines: 1,
                                      style: courierFont14W600ProfileHintColor,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      filesize(uploadedVideos[index].size),
                                      style: courierFont12W600ProfileHintColor,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Container(
                                width: dim_100,
                                height: dim_1,
                                color: ColorResources.black,
                              ),
                            );
                          },
                        ),
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
                              if ((uploadedAudio.length +
                                      result.files.length) <=
                                  AppConstants.maxAudioSelected) {
                                for (var file in result.files) {
                                  if (file.size <
                                      (AppConstants.maxAudioLength *
                                          AppConstants.mbToBytes)) {
                                    selectedAudio.add(file);
                                    for (var platFormObj in selectedAudio) {
                                      uploadedAudio.add(MediaFileModel(
                                          url: "",
                                          size: platFormObj.size,
                                          upload: true,
                                          name: platFormObj.name,
                                          path: platFormObj.path));
                                    }
                                  } else {
                                    Utils.showSnackBar(context,
                                        "Max size limit for selected audio is ${AppConstants.maxAudioLength} MB");
                                  }
                                }
                                setState(() {});
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
                        ListView.builder(
                            itemCount: uploadedAudio.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        uploadedAudio[index].name,
                                        maxLines: 1,
                                        style:
                                            courierFont14W600ProfileHintColor,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        filesize(uploadedAudio[index].size),
                                        style:
                                            courierFont12W600ProfileHintColor,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Container(
                                  width: dim_100,
                                  height: dim_1,
                                  color: ColorResources.black,
                                ),
                              );
                            }),
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

          bool isSuccess = await FirebaseRealtimeDataService().saveIncident(
            _calendarSelectedDate,
            prepareRequestBody(),
          );

          Fluttertoast.showToast(
              msg: isSuccess
                  ? "Data submitted successfully"
                  : "Failed to submit dta");
          if (isSuccess) {
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
          uploadedImages[]
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
                  padding: const EdgeInsets.only(
                      right: dim_8, top: dim_8, bottom: dim_8),
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
}
