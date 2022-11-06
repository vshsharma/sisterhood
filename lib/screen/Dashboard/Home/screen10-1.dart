// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sisterhood_app/screen/Dashboard/Home/screen10.dart';
// import 'package:sisterhood_app/screen/Dashboard/Home/screen10_2.dart';
// import 'package:sisterhood_app/utill/color_resources.dart';
// import 'package:sisterhood_app/utill/images.dart';
// import 'package:sisterhood_app/utill/strings.dart';
//
// class Screen10_1Page extends StatefulWidget {
//   const Screen10_1Page({Key key}) : super(key: key);
//
//   @override
//   _Screen10_1PageState createState() => _Screen10_1PageState();
// }
//
// class _Screen10_1PageState extends State<Screen10_1Page> {
//
//   final _formKey = GlobalKey<FormState>();
//
//   final _controller1 = TextEditingController();
//   final _controller2 = TextEditingController();
//   final _controller3 = TextEditingController();
//   final _controller4 = TextEditingController();
//   final _controller5 = TextEditingController();
//   final _controller6 = TextEditingController();
//   final _controller7 = TextEditingController();
//   final _controller8 = TextEditingController();
//   final _controller9 = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: ColorResources.background,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: ColorResources.background,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 5.0,top: 10),
//             child: Column(
//               children: [
//                 InkWell(
//                     onTap: (){
//                       Navigator.of(context).pop();
//                     },
//                     child: const Icon(Icons.keyboard_arrow_left_outlined,color: ColorResources.grey,size: 35,)),
//                 // Image.asset(Images.commonlogo,scale: 20,),
//                 // Image.asset(Images.Sisterhood,scale: 20,),
//               ],
//             ),
//           ),
//           // title: Image.asset(Images.logo,width: 50,),
//           actions: [
//             InkWell(
//               onTap:()=> exit(0),
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: Image.asset(Images.loginImage,width: 30,height: 30,),
//               ),
//             ),
//           ],
//         ),
//         body: SafeArea(
//             child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text("Fridy 17 Frbruary 2022 16:06",
//                               style: TextStyle(
//                                 color: ColorResources.profilePlaceholderColor,
//                                 fontSize: 20,
//                                 // letterSpacing: 1,
//                                 fontFamily: 'Arial',
//                                 fontWeight: FontWeight.bold,
//                               )),
//                           const SizedBox(height: 20),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(Strings.what_type_of_abuse,
//                                   style: TextStyle(
//                                     color: ColorResources.profilePlaceholderColor,
//                                     fontSize: 16,
//                                     // letterSpacing: 1,
//                                     fontFamily: 'Courier',
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               const SizedBox(height: 5,),
//                               _editField1(),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(Strings.tell_me_what_happend,
//                                   style: TextStyle(
//                                     color: ColorResources.profilePlaceholderColor,
//                                     fontSize: 16,
//                                     // letterSpacing: 1,
//                                     fontFamily: 'Courier',
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               const SizedBox(height: 5,),
//                               _editField2(),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(Strings.what_were_the_circumstances,
//                                   style: TextStyle(
//                                     color: ColorResources.profilePlaceholderColor,
//                                     fontSize: 16,
//                                     // letterSpacing: 1,
//                                     fontFamily: 'Courier',
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               SizedBox(height: 5,),
//                               _editField3(),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(Strings.where_did_it_happen,
//                                   style: TextStyle(
//                                     color: ColorResources.profilePlaceholderColor,
//                                     fontSize: 16,
//                                     // letterSpacing: 1,
//                                     fontFamily: 'Courier',
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               SizedBox(height: 5,),
//                               _editField4(),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(Strings.if_outside_or_other_area_please_specify,
//                                   style: TextStyle(
//                                     color: ColorResources.profilePlaceholderColor,
//                                     fontSize: 16,
//                                     // letterSpacing: 1,
//                                     fontFamily: 'Courier',
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               SizedBox(height: 5,),
//                               _editField5(),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(Strings.when_did_it_happen,
//                                   style: TextStyle(
//                                     color: ColorResources.profilePlaceholderColor,
//                                     fontSize: 16,
//                                     // letterSpacing: 1,
//                                     fontFamily: 'Courier',
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               SizedBox(height: 5,),
//                               _editField6(),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(Strings.was_your_partner_under_the_influence,
//                                   style: TextStyle(
//                                     color: ColorResources.profilePlaceholderColor,
//                                     fontSize: 16,
//                                     // letterSpacing: 1,
//                                     fontFamily: 'Courier',
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               SizedBox(height: 5,),
//                               _editField7(),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(Strings.where_you_under_the_influence,
//                                   style: TextStyle(
//                                     color: ColorResources.profilePlaceholderColor,
//                                     fontSize: 16,
//                                     // letterSpacing: 1,
//                                     fontFamily: 'Courier',
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               SizedBox(height: 5,),
//                               _editField8(),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(Strings.have_you_seeked_medical_attention,
//                                   style: TextStyle(
//                                     color: ColorResources.profilePlaceholderColor,
//                                     fontSize: 16,
//                                     // letterSpacing: 1,
//                                     fontFamily: 'Courier',
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               SizedBox(height: 5,),
//                               _editField9(),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           SizedBox(height: 30),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: InkWell(
//                                   onTap: (){
//                                     Navigator.of(context).pop(true);
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: ColorResources.box_border,
//                                         width: 1,
//                                       ),
//                                       color: ColorResources.box_background,
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                     height: 60,
//                                     alignment: Alignment.topCenter,
//                                    child: const Center(
//                                       child: Text(Strings.back,
//                                           style: TextStyle(
//                                             color: ColorResources.black,
//                                             fontSize: 18,
//                                             fontFamily: 'Courier',
//                                             letterSpacing: 1,
//                                             fontWeight: FontWeight.bold,
//                                           )),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//                               SizedBox(width: 20,),
//                               Expanded(
//                                 flex: 5,
//                                 child: InkWell(
//                                   onTap: (){
//                                     // Navigator.of(context)
//                                     //     .push(MaterialPageRoute(builder: (context) => Screen10Page()));
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: ColorResources.box_border,
//                                         width: 1,
//                                       ),
//                                       color: ColorResources.box_background,
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                     height: 60,
//                                     alignment: Alignment.topCenter,
//                                     child: Center(
//                                       child: Text(Strings.edit,
//                                           style: TextStyle(
//                                             color: ColorResources.black,
//                                             fontSize: 18,
//                                             fontFamily: 'Courier',
//                                             letterSpacing: 1,
//                                             fontWeight: FontWeight.bold,
//                                           )),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 30,),
//
//                         ]),
//                   ),
//                 )
//             )
//         )
//     );
//   }
//
//   _editField1() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorResources.box_borderscreen10,
//           width: 1,
//         ),
//         // color: ColorResources.box_background,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       height: 60,
//       alignment: Alignment.topCenter,
//       child: TextFormField(
//         controller: _controller1,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textAlignVertical: TextAlignVertical.bottom,
//         style: const TextStyle(
//             color: ColorResources.profilehintColor,
//             fontSize: 18,
//             letterSpacing: 0.5,
//             fontFamily: 'Courier',
//             fontWeight: FontWeight.w600
//         ),
//         decoration: const InputDecoration(
//           // hintText: Strings.first_name,
//           hintStyle: TextStyle(
//               color: ColorResources.profilehintColor,
//               fontSize: 18,
//               letterSpacing: 0.5,
//               fontFamily: 'Courier',
//               fontWeight: FontWeight.w600
//           ),
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
//
//   _editField2() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorResources.box_borderscreen10,
//           width: 1,
//         ),
//         // color: ColorResources.box_background,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       height: 60,
//       alignment: Alignment.topCenter,
//       child: TextFormField(
//         controller: _controller2,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textAlignVertical: TextAlignVertical.bottom,
//         style: const TextStyle(
//             color: ColorResources.profilehintColor,
//             fontSize: 18,
//             letterSpacing: 0.5,
//             fontFamily: 'Courier',
//             fontWeight: FontWeight.w600
//         ),
//         decoration: const InputDecoration(
//           // hintText: Strings.first_name,
//           hintStyle: TextStyle(
//               color: ColorResources.profilehintColor,
//               fontSize: 18,
//               letterSpacing: 0.5,
//               fontFamily: 'Courier',
//               fontWeight: FontWeight.w600
//           ),
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
//
//   _editField3() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorResources.box_borderscreen10,
//           width: 1,
//         ),
//         // color: ColorResources.box_background,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       height: 60,
//       alignment: Alignment.topCenter,
//       child: TextFormField(
//         controller: _controller3,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textAlignVertical: TextAlignVertical.bottom,
//         style: const TextStyle(
//             color: ColorResources.profilehintColor,
//             fontSize: 18,
//             letterSpacing: 0.5,
//             fontFamily: 'Courier',
//             fontWeight: FontWeight.w600
//         ),
//         decoration: const InputDecoration(
//           // hintText: Strings.first_name,
//           hintStyle: TextStyle(
//               color: ColorResources.profilehintColor,
//               fontSize: 18,
//               letterSpacing: 0.5,
//               fontFamily: 'Courier',
//               fontWeight: FontWeight.w600
//           ),
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
//
//   _editField4() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorResources.box_borderscreen10,
//           width: 1,
//         ),
//         // color: ColorResources.box_background,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       height: 60,
//       alignment: Alignment.topCenter,
//       child: TextFormField(
//         controller: _controller4,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textAlignVertical: TextAlignVertical.bottom,
//         style: const TextStyle(
//             color: ColorResources.profilehintColor,
//             fontSize: 18,
//             letterSpacing: 0.5,
//             fontFamily: 'Courier',
//             fontWeight: FontWeight.w600
//         ),
//         decoration: const InputDecoration(
//           // hintText: Strings.first_name,
//           hintStyle: TextStyle(
//               color: ColorResources.profilehintColor,
//               fontSize: 18,
//               letterSpacing: 0.5,
//               fontFamily: 'Courier',
//               fontWeight: FontWeight.w600
//           ),
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
//
//   _editField5() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorResources.box_borderscreen10,
//           width: 1,
//         ),
//         // color: ColorResources.box_background,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       height: 60,
//       alignment: Alignment.topCenter,
//       child: TextFormField(
//         controller: _controller5,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textAlignVertical: TextAlignVertical.bottom,
//         style: const TextStyle(
//             color: ColorResources.profilehintColor,
//             fontSize: 18,
//             letterSpacing: 0.5,
//             fontFamily: 'Courier',
//             fontWeight: FontWeight.w600
//         ),
//         decoration: const InputDecoration(
//           // hintText: Strings.first_name,
//           hintStyle: TextStyle(
//               color: ColorResources.profilehintColor,
//               fontSize: 18,
//               letterSpacing: 0.5,
//               fontFamily: 'Courier',
//               fontWeight: FontWeight.w600
//           ),
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
//
//   _editField6() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorResources.box_borderscreen10,
//           width: 1,
//         ),
//         // color: ColorResources.box_background,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       height: 60,
//       alignment: Alignment.topCenter,
//       child: TextFormField(
//         controller: _controller6,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textAlignVertical: TextAlignVertical.bottom,
//         style: const TextStyle(
//             color: ColorResources.profilehintColor,
//             fontSize: 18,
//             letterSpacing: 0.5,
//             fontFamily: 'Courier',
//             fontWeight: FontWeight.w600
//         ),
//         decoration: const InputDecoration(
//           // hintText: Strings.first_name,
//           hintStyle: TextStyle(
//               color: ColorResources.profilehintColor,
//               fontSize: 18,
//               letterSpacing: 0.5,
//               fontFamily: 'Courier',
//               fontWeight: FontWeight.w600
//           ),
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
//
//   _editField7() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorResources.box_borderscreen10,
//           width: 1,
//         ),
//         // color: ColorResources.box_background,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       height: 60,
//       alignment: Alignment.topCenter,
//       child: TextFormField(
//         controller: _controller7,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textAlignVertical: TextAlignVertical.bottom,
//         style: const TextStyle(
//             color: ColorResources.profilehintColor,
//             fontSize: 18,
//             letterSpacing: 0.5,
//             fontFamily: 'Courier',
//             fontWeight: FontWeight.w600
//         ),
//         decoration: const InputDecoration(
//           // hintText: Strings.first_name,
//           hintStyle: TextStyle(
//               color: ColorResources.profilehintColor,
//               fontSize: 18,
//               letterSpacing: 0.5,
//               fontFamily: 'Courier',
//               fontWeight: FontWeight.w600
//           ),
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
//
//   _editField8() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorResources.box_borderscreen10,
//           width: 1,
//         ),
//         // color: ColorResources.box_background,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       height: 60,
//       alignment: Alignment.topCenter,
//       child: TextFormField(
//         controller: _controller8,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textAlignVertical: TextAlignVertical.bottom,
//         style: const TextStyle(
//             color: ColorResources.profilehintColor,
//             fontSize: 18,
//             letterSpacing: 0.5,
//             fontFamily: 'Courier',
//             fontWeight: FontWeight.w600
//         ),
//         decoration: const InputDecoration(
//           // hintText: Strings.first_name,
//           hintStyle: TextStyle(
//               color: ColorResources.profilehintColor,
//               fontSize: 18,
//               letterSpacing: 0.5,
//               fontFamily: 'Courier',
//               fontWeight: FontWeight.w600
//           ),
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
//
//   _editField9() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: ColorResources.box_borderscreen10,
//           width: 1,
//         ),
//         // color: ColorResources.box_background,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       height: 60,
//       alignment: Alignment.topCenter,
//       child: TextFormField(
//         controller: _controller9,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         textAlignVertical: TextAlignVertical.bottom,
//         style: const TextStyle(
//             color: ColorResources.profilehintColor,
//             fontSize: 18,
//             letterSpacing: 0.5,
//             fontFamily: 'Courier',
//             fontWeight: FontWeight.w600
//         ),
//         decoration: const InputDecoration(
//           // hintText: Strings.first_name,
//           hintStyle: TextStyle(
//               color: ColorResources.profilehintColor,
//               fontSize: 18,
//               letterSpacing: 0.5,
//               fontFamily: 'Courier',
//               fontWeight: FontWeight.w600
//           ),
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
