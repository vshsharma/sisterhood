// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:sisterhood_app/screen/Dashboard/Home/model/incident_model.dart';
// import 'package:sisterhood_app/screen/Dashboard/Home/pre_journal_data.dart';
// import 'package:sisterhood_app/screen/app_widgets/radio_button_group.dart';
// import 'package:sisterhood_app/screen/common/base_widget.dart';
// import 'package:sisterhood_app/screen/common/date_util.dart';
// import 'package:sisterhood_app/utill/app_paddings.dart';
// import 'package:sisterhood_app/utill/color_resources.dart';
// import 'package:sisterhood_app/utill/custom_button.dart';
// import 'package:sisterhood_app/utill/dimension.dart';
// import 'package:sisterhood_app/utill/images.dart';
// import 'package:sisterhood_app/utill/strings.dart';
//
// import '../../../utill/styles.dart';
// import '../../app_widgets/checkbox_group.dart';
// import '../../app_widgets/next_previous_cta.dart';
// import '../../common/common_card.dart';
// import '../../common/custom_edit_text.dart';
// import '../../firebase.dart';
//
// class EditJournalEntryPager extends StatefulWidget {
//   final IncidentModel _incidentModel;
//
//   const EditJournalEntryPager(this._incidentModel);
//
//   @override
//   _EditJournalEntryPagePageState createState() =>
//       _EditJournalEntryPagePageState();
// }
//
// class _EditJournalEntryPagePageState extends State<EditJournalEntryPager> {
//   final _formKey = GlobalKey<FormState>();
//   var isSelected = false;
//   final _auth = FirebaseAuth.instance;
//   var isMediaAdded = "false";
//   TimeOfDay selectedTime = TimeOfDay.now();
//   String pictureUrl = '';
//   String videoUrl = '';
//   String audioUrl = '';
//   String fileUrl = '';
//   bool isLoad = false;
//   bool showBottomCTA = true;
//   File filePicture, fileVideo, fileDocument, fileAudio;
//   DateTime _targetDateTime = DateTime.now();
//   DateTime _calendarSelectedDate = DateTime.now();
//
//   // RequiredData
//   List<String> checkedAbuseType = [];
//   List<String> checkWhereItHappen = [];
//   List<String> checkPartnerUnderInfluence = [];
//   List<String> checkIfYouUnderInfluence = [];
//   String checkMedicalAssistant = 'No';
//
//   final _whatHappenTextController = TextEditingController();
//   final _circumstancesTextConroller = TextEditingController();
//   final _areaSpecifyTextController = TextEditingController();
//   final _medicalAssistantTextController = TextEditingController();
//   final _dateTimeTextController = TextEditingController();
//
//   DateTime dateTime = DateTime.now();
//
//   var pageController = PageController();
//   static const _kDuration = const Duration(milliseconds: 300);
//   static const _kCurve = Curves.ease;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget._incidentModel.wouldyouliketorecord.isNotEmpty) {
//       checkedAbuseType = json
//           .decode(widget._incidentModel.wouldyouliketorecord)
//           .cast<String>();
//     }
//     if (widget._incidentModel.happen.isNotEmpty) {
//       checkWhereItHappen =
//           json.decode(widget._incidentModel.happen).cast<String>();
//     }
//     if (widget._incidentModel.partnerundertheinfluence.isNotEmpty) {
//       checkPartnerUnderInfluence = json
//           .decode(widget._incidentModel.partnerundertheinfluence)
//           .cast<String>();
//     }
//     if (widget._incidentModel.undertheinfluence.isNotEmpty) {
//       checkIfYouUnderInfluence =
//           json.decode(widget._incidentModel.undertheinfluence).cast<String>();
//     }
//     if (widget._incidentModel.resultincident.isNotEmpty) {
//       checkMedicalAssistant = widget._incidentModel.resultincident;
//     }
//     if (widget._incidentModel.whathappend.isNotEmpty) {
//       _whatHappenTextController.text = widget._incidentModel.whathappend;
//     }
//     if (widget._incidentModel.circumstances.isNotEmpty) {
//       _circumstancesTextConroller.text = widget._incidentModel.circumstances;
//     }
//     if (widget._incidentModel.outsideareaspecify.isNotEmpty) {
//       _areaSpecifyTextController.text =
//           widget._incidentModel.outsideareaspecify;
//     }
//     if (widget._incidentModel.datewithhappen.isNotEmpty) {
//       _dateTimeTextController.text = widget._incidentModel.datewithhappen;
//     }
//     if (widget._incidentModel.popuptext.isNotEmpty) {
//       _medicalAssistantTextController.text = widget._incidentModel.popuptext;
//     }
//     if (widget._incidentModel.picture.isNotEmpty) {
//       isMediaAdded = "true";
//       pictureUrl = widget._incidentModel.picture;
//     }
//     if (widget._incidentModel.audio.isNotEmpty) {
//       isMediaAdded = "true";
//       audioUrl = widget._incidentModel.audio;
//     }
//     if (widget._incidentModel.video.isNotEmpty) {
//       isMediaAdded = "true";
//       videoUrl = widget._incidentModel.video;
//     }
//     if (widget._incidentModel.document.isNotEmpty) {
//       isMediaAdded = "true";
//       fileUrl = widget._incidentModel.document;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseWidget(Column(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(left: dim_10, right: dim_10),
//             child: Form(
//               key: _formKey,
//               child: PageView(
//                 onPageChanged: (int page) {
//                   setState(() {
//                     print("Current page is: $page");
//                     showBottomCTA = page < 9;
//                   });
//                 },
//                 controller: pageController,
//                 children: [
//                   CommonCard(Column(
//                     children: [
//                       const Padding(
//                         padding: cardPadding,
//                         child: Text(Strings.what_type_of_abuse,
//                             style: TextStyle(
//                               color: ColorResources.profilePlaceholderColor,
//                               fontSize: font_18,
//                               fontFamily: 'Courier',
//                               fontWeight: FontWeight.w600,
//                             )),
//                       ),
//                       CheckboxGroup(
//                           labels: abuseCategoryList,
//                           subLabels: abuseSubCategoryList,
//                           showDescription: true,
//                           checked: checkedAbuseType,
//                           onChange: (bool isChecked, String label, int index) =>
//                               print(
//                                   "isChecked: $isChecked   label: $label  index: $index"),
//                           onSelected: (List<String> checked) {
//                             setState(() {
//                               checkedAbuseType = checked;
//                             });
//                           }),
//                       const SizedBox(
//                         height: dim_20,
//                       ),
//                     ],
//                   )),
//                   CommonCard(
//                     Padding(
//                       padding: cardPadding,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(Strings.tell_me_what_happend,
//                               style: courierFont18W600ProfileHintColor),
//                           const SizedBox(
//                             height: dim_20,
//                           ),
//                           CustomEditTextField(_whatHappenTextController)
//                           // explain what happened
//                         ],
//                       ),
//                     ),
//                   ), // explain what happened
//                   CommonCard(
//                     Padding(
//                       padding: cardPadding,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(Strings.what_were_the_circumstances,
//                               style: courierFont18W600ProfileHintColor),
//                           const SizedBox(
//                             height: dim_20,
//                           ),
//                           CustomEditTextField(_circumstancesTextConroller),
//                         ],
//                       ),
//                     ),
//                   ), //what were the circumstances
//                   CommonCard(Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: cardPadding,
//                         child: Text(Strings.where_did_it_happen,
//                             style: courierFont18W600Profile),
//                       ),
//                       CheckboxGroup(
//                         labels: incidentPlace,
//                         checked: checkWhereItHappen,
//                         onChange: (bool isChecked, String label, int index) =>
//                             print(
//                                 "isChecked: $isChecked   label: $label  index: $index"),
//                         onSelected: (List<String> checked) {
//                           setState(() {
//                             checkWhereItHappen = checked;
//                           });
//                         },
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   )),
//                   CommonCard(
//                     Padding(
//                       padding: cardPadding,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                               Strings.if_outside_or_other_area_please_specify,
//                               style: courierFont18W600ProfileHintColor),
//                           const SizedBox(
//                             height: dim_20,
//                           ),
//                           CustomEditTextField(_areaSpecifyTextController),
//                         ],
//                       ),
//                     ),
//                   ),
//                   CommonCard(
//                     Padding(
//                       padding: cardPadding,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(Strings.when_did_it_happen,
//                               style: courierFont18W600ProfilePlaceHolder),
//                           const SizedBox(
//                             height: dim_15,
//                           ),
//                           CalendarCarousel<Event>(
//                             todayBorderColor: Colors.black,
//                             weekdayTextStyle:
//                                 const TextStyle(color: ColorResources.black),
//                             onDayPressed: (date, events) {
//                               this.setState(() => _calendarSelectedDate = date);
//                               print('onDayPressed: $date');
//                               events.forEach((event) => print(event.title));
//                               openDialogToGetIncidentTime(context);
//                             },
//                             daysHaveCircularBorder: true,
//                             showOnlyCurrentMonthDate: true,
//                             firstDayOfWeek: 1,
//                             weekendTextStyle: const TextStyle(
//                               color: Colors.black,
//                             ),
//                             weekFormat: false,
//                             height: Get.height / 2,
//                             selectedDateTime: _calendarSelectedDate,
//                             targetDateTime: _targetDateTime,
//                             customGridViewPhysics:
//                                 const NeverScrollableScrollPhysics(),
//                             markedDateCustomShapeBorder: const CircleBorder(
//                               side: BorderSide(color: Colors.black),
//                             ),
//                             selectedDayButtonColor:
//                                 ColorResources.box_background,
//                             selectedDayBorderColor: Colors.black,
//                             markedDateCustomTextStyle: const TextStyle(
//                               fontSize: font_18,
//                               color: Colors.black,
//                             ),
//                             showHeader: true,
//                             iconColor: Colors.black,
//                             headerTextStyle: const TextStyle(
//                               color: ColorResources.profilePlaceholderColor,
//                               fontSize: font_18,
//                               fontFamily: 'Arial',
//                               fontWeight: FontWeight.bold,
//                             ),
//                             todayTextStyle:
//                                 const TextStyle(color: ColorResources.black),
//                             todayButtonColor: ColorResources.box_background,
//                             selectedDayTextStyle: const TextStyle(
//                               color: ColorResources.black,
//                             ),
//                             minSelectedDate:
//                                 DateTime.now().subtract(Duration(days: 360)),
//                             maxSelectedDate:
//                                 DateTime.now().add(const Duration(days: 360)),
//                             onCalendarChanged: (DateTime date) {
//                               setState(() {
//                                 _targetDateTime = date;
//                                 print('onDayPressed1: $_targetDateTime');
//                                 // _currentMonth =
//                                 //     DateFormat.yMMM().format(_targetDateTime);
//                               });
//                             },
//                             onDayLongPressed: (DateTime date) {},
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   CommonCard(
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding: cardPadding,
//                           child: Text(
//                               Strings.was_your_partner_under_the_influence,
//                               style: TextStyle(
//                                 color: ColorResources.profilePlaceholderColor,
//                                 fontSize: 18,
//                                 // letterSpacing: 1,
//                                 fontFamily: 'Courier',
//                                 fontWeight: FontWeight.bold,
//                               )),
//                         ),
//                         CheckboxGroup(
//                             labels: underInfluenceOption,
//                             checked: checkPartnerUnderInfluence,
//                             onSelected: (List<String> checked) {
//                               setState(() {
//                                 checkPartnerUnderInfluence = checked;
//                               });
//                             }),
//                         SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                   CommonCard(
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding: cardPadding,
//                           child: Text(Strings.where_you_under_the_influence,
//                               style: courierFont18W600ProfilePlaceHolder),
//                         ),
//                         CheckboxGroup(
//                             labels: underInfluenceOption,
//                             checked: checkIfYouUnderInfluence,
//                             onSelected: (List<String> checked) {
//                               setState(() {
//                                 checkIfYouUnderInfluence = checked;
//                               });
//                             }),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                   CommonCard(
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding: cardPadding,
//                           child: Text(Strings.have_you_seeked_medical_attention,
//                               style: courierFont18W600ProfileHintColor),
//                         ),
//                         RadioButtonGroup(
//                             labels: seekedMedicalAttentionOption,
//                             picked: checkMedicalAssistant,
//                             onSelected: (String selected) {
//                               setState(() {
//                                 checkMedicalAssistant = selected;
//                               });
//                               print(selected);
//                               if (selected == "Yes") {
//                                 medicalAssistantPopUp(context);
//                               }
//                             }),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: InkWell(
//                                 onTap: () async {
//                                   await buildShowModalBottomSheet(context);
//                                 },
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: ColorResources.box_border,
//                                         width: 1,
//                                       ),
//                                       color: ColorResources.box_background,
//                                       borderRadius:
//                                           BorderRadius.circular(dim_10),
//                                     ),
//                                     child: Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: dim_20),
//                                         child: Column(
//                                           children: [
//                                             pictureUrl.isNotEmpty
//                                                 ? Image.network(
//                                                     pictureUrl,
//                                                     width: 40.0,
//                                                     height: 40.0,
//                                                   )
//                                                 : Image.asset(
//                                                     Images.gallery,
//                                                     color: filePicture ==
//                                                                 null &&
//                                                             pictureUrl.isEmpty
//                                                         ? Colors.black
//                                                         : Colors.green,
//                                                     width: dim_35,
//                                                     height: dim_35,
//                                                   ),
//                                             const SizedBox(
//                                               height: dim_20,
//                                             ),
//                                             const Text(Strings.add_picture,
//                                                 style: courierFont18W600),
//                                           ],
//                                         ),
//                                       ),
//                                     )),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: dim_15,
//                             ),
//                             Expanded(
//                               flex: 5,
//                               child: InkWell(
//                                 onTap: () async {
//                                   FilePickerResult result = await FilePicker
//                                       .platform
//                                       .pickFiles(type: FileType.video);
//                                   if (result != null) {
//                                     fileVideo = File(result.files.single.path);
//                                     Fluttertoast.showToast(
//                                         msg: "Video uploaded successfully");
//                                     // isMediaAdded = "true";
//                                   } else {
//                                     // User canceled the picker
//                                   }
//                                 },
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: ColorResources.box_border,
//                                         width: 1,
//                                       ),
//                                       color: ColorResources.box_background,
//                                       borderRadius:
//                                           BorderRadius.circular(dim_10),
//                                     ),
//                                     child: Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: dim_20),
//                                         child: Column(
//                                           children: [
//                                             Image.asset(
//                                               Images.video,
//                                               width: dim_35,
//                                               height: dim_35,
//                                               color: fileVideo == null &&
//                                                       videoUrl.isEmpty
//                                                   ? Colors.black
//                                                   : Colors.green,
//                                             ),
//                                             const SizedBox(
//                                               height: dim_20,
//                                             ),
//                                             const Text(Strings.add_video,
//                                                 style: courierFont18W600),
//                                           ],
//                                         ),
//                                       ),
//                                     )),
//                               ),
//                             ),
//                           ]),
//                       const SizedBox(
//                         height: dim_30,
//                       ),
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: InkWell(
//                                 onTap: () async {
//                                   FilePickerResult result = await FilePicker
//                                       .platform
//                                       .pickFiles(allowMultiple: true);
//
//                                   if (result != null) {
//                                     fileDocument =
//                                         File(result.files.single.path);
//                                     Fluttertoast.showToast(
//                                         msg: "Document uploaded successfully");
//                                     // isMediaAdded = "true";
//                                   } else {
//                                     // User canceled the picker
//                                   }
//                                 },
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: ColorResources.box_border,
//                                         width: 1,
//                                       ),
//                                       color: ColorResources.box_background,
//                                       borderRadius:
//                                           BorderRadius.circular(dim_10),
//                                     ),
//                                     child: Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: dim_20),
//                                         child: Column(
//                                           children: [
//                                             Image.asset(
//                                               Images.documenticon,
//                                               color: fileDocument == null &&
//                                                       fileUrl.isEmpty
//                                                   ? Colors.black
//                                                   : Colors.green,
//                                               width: dim_35,
//                                               height: dim_35,
//                                             ),
//                                             const SizedBox(
//                                               height: dim_20,
//                                             ),
//                                             const Text(Strings.add_document,
//                                                 style: courierFont18W600),
//                                           ],
//                                         ),
//                                       ),
//                                     )),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: dim_15,
//                             ),
//                             Expanded(
//                               flex: 5,
//                               child: InkWell(
//                                 onTap: () async {
//                                   FilePickerResult result = await FilePicker
//                                       .platform
//                                       .pickFiles(type: FileType.audio);
//
//                                   if (result != null) {
//                                     fileAudio = File(result.files.single.path);
//                                     Fluttertoast.showToast(
//                                         msg: "Audio uploaded successfully");
//                                     //isMediaAdded = "true";
//                                   } else {
//                                     // User canceled the picker
//                                   }
//                                 },
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: ColorResources.box_border,
//                                         width: dim_1,
//                                       ),
//                                       color: ColorResources.box_background,
//                                       borderRadius:
//                                           BorderRadius.circular(dim_10),
//                                     ),
//                                     child: Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: dim_20),
//                                         child: Column(
//                                           children: [
//                                             Image.asset(
//                                               Images.music,
//                                               color: fileAudio == null &&
//                                                       audioUrl.isEmpty
//                                                   ? Colors.black
//                                                   : Colors.green,
//                                               width: dim_35,
//                                               height: dim_35,
//                                             ),
//                                             // Icon(Icons.volume_up_outlined,size: 35.0,),
//                                             const SizedBox(
//                                               height: dim_20,
//                                             ),
//                                             const Text(Strings.add_Audio,
//                                                 style: courierFont18W600),
//                                           ],
//                                         ),
//                                       ),
//                                     )),
//                               ),
//                             ),
//                           ]),
//                       const SizedBox(
//                         height: dim_80,
//                       ),
//                       if (isLoad)
//                         const Center(child: CircularProgressIndicator())
//                       else
//                         _continueButton(),
//                       const SizedBox(
//                         height: dim_30,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         NextPreviousCTA(
//           showBottomCTA: showBottomCTA,
//           previousBtnCallback: () {
//             pageController.previousPage(
//               duration: _kDuration, curve: _kCurve);},
//           nextBtnCallback: () {
//             pageController.nextPage(
//               duration: _kDuration, curve: _kCurve);},
//         )
//       ],
//     ));
//   }
//
//   buildShowModalBottomSheet(BuildContext context) async {
//     showModalBottomSheet(
//         isDismissible: true,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Wrap(
//               children: <Widget>[
//                 ListTile(
//                     leading: const Icon(
//                       Icons.photo_camera,
//                       size: dim_35,
//                     ),
//                     title: const Text(
//                       'Camera',
//                       style: TextStyle(
//                           fontSize: font_18, fontWeight: FontWeight.w600),
//                     ),
//                     onTap: () async {
//                       final pickedFile = await ImagePicker()
//                           .getImage(source: ImageSource.camera);
//                       if (pickedFile != null) {
//                         setState(() {
//                           filePicture = File(pickedFile.path);
//                           Fluttertoast.showToast(msg: "Image selected");
//                           // isMediaAdded = "true";
//                           Navigator.of(context).pop();
//                         });
//                       } else {
//                         Fluttertoast.showToast(
//                             msg: "Unknown error while image selection");
//                       }
//                     }),
//                 ListTile(
//                   leading: const Icon(
//                     Icons.photo_library,
//                     size: dim_35,
//                   ),
//                   title: const Text(
//                     'Gallery',
//                     style: TextStyle(
//                         fontSize: font_18, fontWeight: FontWeight.w600),
//                   ),
//                   onTap: () async {
//                     FilePickerResult result =
//                         await FilePicker.platform.pickFiles();
//                     if (result != null) {
//                       filePicture = File(result.files.single.path);
//                       Fluttertoast.showToast(msg: "Image selected");
//                       //  isMediaAdded = "true";
//                     } else {
//                       Fluttertoast.showToast(
//                           msg: "Unknown error while image selection");
//                     }
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
//
//   Future<dynamic> openDialogToGetIncidentTime(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: ColorResources.background,
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 const Text(Strings.What_time_did_ithappen,
//                     style: courierFont18W600ProfilePlaceHolder),
//                 const SizedBox(
//                   height: dim_10,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: ColorResources.box_border,
//                       width: dim_1,
//                     ),
//                     color: ColorResources.box_background,
//                     borderRadius: BorderRadius.circular(dim_10),
//                   ),
//                   height: 70,
//                   alignment: Alignment.topCenter,
//                   child: InkWell(
//                     onTap: () async {
//                       showTimerPicker(context, _dateTimeTextController);
//                     },
//                     child: TextFormField(
//                       enabled: false,
//                       controller: _dateTimeTextController,
//                       textAlign: TextAlign.start,
//                       keyboardType: TextInputType.text,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       textAlignVertical: TextAlignVertical.bottom,
//                       style: arialFont14W600,
//                       decoration: const InputDecoration(
//                         hintText: Strings.write_here,
//                         hintStyle: arialFont14W600,
//                         errorBorder:
//                             OutlineInputBorder(borderSide: BorderSide.none),
//                         border: OutlineInputBorder(borderSide: BorderSide.none),
//                       ),
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return "Empty";
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: dim_30,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: dim_25),
//                     child: CustomButton(
//                         text1: Strings.submit,
//                         text2: "",
//                         width: Get.width,
//                         height: dim_50),
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   }
//
//   void medicalAssistantPopUp(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: ColorResources.background,
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 const Text(
//                   Strings.what_medical_facilitydidyouvisit,
//                   style: courierFont18W600ProfilePlaceHolder,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: ColorResources.box_border,
//                       width: 1,
//                     ),
//                     color: ColorResources.box_background,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   height: 60,
//                   alignment: Alignment.topCenter,
//                   child: TextFormField(
//                     controller: _medicalAssistantTextController,
//                     textAlign: TextAlign.start,
//                     keyboardType: TextInputType.text,
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     textAlignVertical: TextAlignVertical.bottom,
//                     style: const TextStyle(
//                         color: ColorResources.profilehintColor,
//                         fontSize: 14,
//                         letterSpacing: 0.5,
//                         fontFamily: 'Arial',
//                         fontWeight: FontWeight.w600),
//                     decoration: const InputDecoration(
//                       hintText: Strings.write_here,
//                       hintStyle: arialFont14W600,
//                       errorBorder:
//                           OutlineInputBorder(borderSide: BorderSide.none),
//                       border: OutlineInputBorder(borderSide: BorderSide.none),
//                     ),
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "Empty";
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                       child: CustomButton(
//                           text1: Strings.submit,
//                           text2: "",
//                           width: Get.width,
//                           height: 50)),
//                 )
//               ],
//             ),
//           );
//         });
//   }
//
//   CommonCard commonCardUI(Widget widget) {
//     return CommonCard(widget);
//   }
//
//   _continueButton() {
//     return GestureDetector(
//       onTap: () async {
//         if (_formKey.currentState.validate()) {
//           // if (isMediaAdded == "false") {
//           //   Fluttertoast.showToast(msg: "Please pick atleast anyone file");
//           // } else {
//           setState(() {
//             isLoad = true;
//           });
//
//           final ref = FirebaseStorage.instance
//               .ref()
//               .child('new_journal')
//               .child(_auth.currentUser.uid + '.jpg');
//
//           await uploadMediaAndGetUrl(
//               filePicture, fileVideo, fileAudio, fileDocument, ref);
//           bool isSuccess = await FirebaseRealtimeDataService().saveIncident(
//             _calendarSelectedDate,
//             prepareRequestBody(),
//           );
//
//           Fluttertoast.showToast(
//               msg: isSuccess
//                   ? "Data submitted successfully"
//                   : "Failed to submit dta");
//           if (isSuccess) {
//             Navigator.pop(context);
//           }
//           setState(() {
//             isLoad = false;
//           });
//           // }
//         }
//       },
//       child: CustomButton(
//           text1: Strings.submit, text2: "", width: Get.width, height: 60),
//     );
//   }
//
//   String prepareRequestBody() {
//     return json.encode({
//       'wouldyouliketorecord': json.encode(checkedAbuseType).toString(),
//       'whathappend': _whatHappenTextController.text,
//       'circumstances': _circumstancesTextConroller.text,
//       'happen': json.encode(checkWhereItHappen).toString(),
//       'outsideareaspecify': _areaSpecifyTextController.text,
//       'datewithhappen': _dateTimeTextController.text,
//       'dateStamp': _calendarSelectedDate.toString(),
//       'partnerundertheinfluence':
//           json.encode(checkPartnerUnderInfluence).toString(),
//       'undertheinfluence': json.encode(checkIfYouUnderInfluence).toString(),
//       'resultincident': checkMedicalAssistant,
//       'popuptext': _medicalAssistantTextController.text,
//       'picture': pictureUrl,
//       'video': videoUrl,
//       'document': fileUrl,
//       'audio': audioUrl,
//     });
//   }
//
//   Future<bool> uploadMediaAndGetUrl(File filePicture, File fileVideo,
//       File fileAudio, File fileDocument, Reference ref) async {
//     await uploadPicture(filePicture, ref);
//     await uplodVideo(fileVideo, ref);
//     await uploadAudio(fileAudio, ref);
//     await uploadDocument(fileDocument, ref);
//     return true;
//   }
//
//   Future<void> uploadDocument(File fileDocument, Reference ref) async {
//     if (fileDocument != null) {
//       await ref.putFile(fileDocument);
//       fileUrl = await ref.getDownloadURL();
//     }
//   }
//
//   Future<void> uploadAudio(File fileAudio, Reference ref) async {
//     if (fileAudio != null) {
//       await ref.putFile(fileAudio);
//       audioUrl = await ref.getDownloadURL();
//     }
//   }
//
//   Future<void> uplodVideo(File fileVideo, Reference ref) async {
//     if (fileVideo != null) {
//       await ref.putFile(fileVideo);
//       videoUrl = await ref.getDownloadURL();
//     }
//   }
//
//   Future<void> uploadPicture(File filePicture, Reference ref) async {
//     if (filePicture != null) {
//       await ref.putFile(filePicture);
//       pictureUrl = await ref.getDownloadURL();
//     }
//   }
//
//   _selectTime(BuildContext context, TextEditingController popupcalender) async {
//     final TimeOfDay result = await showTimePicker(
//         context: context,
//         initialTime: selectedTime,
//         builder: (context, childWidget) {
//           return MediaQuery(
//               data:
//                   MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//               child: childWidget);
//         });
//     if (result != null && result != selectedTime) {
//       setState(() {
//         selectedTime = result;
//       });
//     }
//   }
//
//   showTimerPicker(BuildContext context, TextEditingController _popupcalender) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: ColorResources.background,
//             title: const Text('Select Time'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       right: dim_8, top: dim_8, bottom: dim_8),
//                   child: TimePickerSpinner(
//                     alignment: Alignment.center,
//                     is24HourMode: true,
//                     normalTextStyle: const TextStyle(
//                         fontSize: font_18, color: Colors.black45),
//                     highlightedTextStyle:
//                         const TextStyle(fontSize: font_22, color: Colors.black),
//                     onTimeChange: (time) {
//                       setState(() {
//                         _popupcalender.text =
//                             DateUtil.getDate(_calendarSelectedDate) +
//                                 ' ' +
//                                 DateUtil.getTime(time);
//                         print('Hello $time');
//                       });
//                     },
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: dim_25),
//                     child: CustomButton(
//                         text1: Strings.submit,
//                         text2: "",
//                         width: Get.width,
//                         height: dim_50),
//                   ),
//                 )
//               ],
//             ),
//           ); // Time picker close
//         });
//   }
// }
