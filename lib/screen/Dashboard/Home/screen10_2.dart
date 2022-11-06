// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sisterhood_app/screen/Dashboard/Home/model/incident_model.dart';
// import 'package:sisterhood_app/screen/Dashboard/Home/screen10-1.dart';
// import 'package:sisterhood_app/screen/Dashboard/Home/screen10.dart';
// import 'package:sisterhood_app/screen/common/date_util.dart';
// import 'package:sisterhood_app/utill/color_resources.dart';
// import 'package:sisterhood_app/utill/images.dart';
// import 'package:sisterhood_app/utill/strings.dart';
// import 'package:sisterhood_app/utill/styles.dart';
//
// import '../../../utill/dimension.dart';
// import 'edit_journal_entry.dart';
//
// class Screen10_2Page extends StatefulWidget {
//   final IncidentModel incidentModel;
//   const Screen10_2Page(this.incidentModel, {Key key}) : super(key: key);
//
//   @override
//   _Screen10_2PageState createState() => _Screen10_2PageState();
// }
//
// class _Screen10_2PageState extends State<Screen10_2Page> {
//   IncidentModel _incidentModel;
//   final _formKey = GlobalKey<FormState>();
//
//   final _controller1 = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _incidentModel = widget.incidentModel;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorResources.background,
//       appBar: AppBar(
//         elevation: dim_0,
//         backgroundColor: ColorResources.background,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: dim_5, top: dim_10),
//           child: Column(
//             children: [
//               InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Icon(
//                     Icons.keyboard_arrow_left_outlined,
//                     color: ColorResources.grey,
//                     size: dim_35,
//                   )),
//             ],
//           ),
//         ),
//         // title: Image.asset(Images.logo,width: 50,),
//         actions: [
//           InkWell(
//             onTap: () => exit(0),
//             child: Padding(
//               padding: const EdgeInsets.only(right: dim_10),
//               child: Image.asset(
//                 Images.loginImage,
//                 width: dim_30,
//                 height: dim_30,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(dim_20),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.6,
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(DateUtil.getDateWithMonthName(_incidentModel.datewithhappen),
//                               style: arialFont20W600ProfilePlaceHolder),
//                           const SizedBox(height: dim_20),
//                           _editField1(_incidentModel),
//                           const SizedBox(height: dim_20),
//                           const SizedBox(height: dim_20),
//                           const SizedBox(
//                             height: dim_30,
//                           ),
//                         ]),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) => EditJournalEntryPage(_incidentModel)));
//                     // Navigator.of(context).push(MaterialPageRoute(
//                     //     builder: (context) => Screen10Page(_incidentModel)));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: ColorResources.box_border,
//                         width: dim_1,
//                       ),
//                       color: ColorResources.box_background,
//                       borderRadius: BorderRadius.circular(dim_15),
//                     ),
//                     height: dim_60,
//                     alignment: Alignment.topCenter,
//                     child: const Center(
//                       child: Text(Strings.edit, style: courierFont18W600),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _editField1(IncidentModel incidentModel) {
//     _controller1.text =incidentModel.whathappend;
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorResources.box_borderscreen10,
//           width: dim_1,
//         ),
//         // color: ColorResources.box_background,
//         borderRadius: BorderRadius.circular(dim_10),
//       ),
//       height: 100,
//       alignment: Alignment.topCenter,
//       child: TextFormField(
//         controller: _controller1,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textAlignVertical: TextAlignVertical.bottom,
//         style: courierFont18W600ProfileHintColor,
//         decoration: const InputDecoration(
//           hintText: "JOURNAL ENTRY FROM THAT DAY",
//           hintStyle: courierFont18W600ProfileHintColor,
//           errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
//           border: OutlineInputBorder(borderSide: BorderSide.none),
//         ),
//         validator: (value) {
//           if (value.isEmpty) {
//             return "Empty";
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
