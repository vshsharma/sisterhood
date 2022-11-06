// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sisterhood_app/screen/common/base_widget.dart';
// import 'package:sisterhood_app/screen/self_help/self_help_tools_option.dart';
// import 'package:sisterhood_app/utill/extension.dart';
//
// import '../../utill/dimension.dart';
// import '../../utill/styles.dart';
// import '../common/resource_button.dart';
//
// class SelfHelpTools extends StatefulWidget {
//   const SelfHelpTools({Key key}) : super(key: key);
//
//   @override
//   _SelfHelpToolsState createState() => _SelfHelpToolsState();
// }
//
// class _SelfHelpToolsState extends State<SelfHelpTools> {
//   @override
//   Widget build(BuildContext context) {
//     return BaseWidget(
//       Center(
//         child: Padding(
//           padding: const EdgeInsets.all(dim_20),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Text(
//                   context.loc.self_help_tools,
//                   textAlign: TextAlign.center,
//                   softWrap: true,
//                   style: courierFont25W700Black,
//                 ),
//                 const SizedBox(height: dim_40),
//                 ResourceButton(
//                   labelButton: context.loc.creating_a_safety_plan,
//                   onButtonPress: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => const SelfHelpToolsOption()));
//                   },
//                 ),
//                 ResourceButton(
//                   labelButton: context.loc.need_things_from_my_apartment,
//                   onButtonPress: () {},
//                 ),
//                 ResourceButton(
//                   labelButton: context.loc.my_partner_force_to_deb,
//                   onButtonPress: () {},
//                 ),
//                 ResourceButton(
//                   labelButton: context.loc.custody_of_child,
//                   onButtonPress: () {},
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
