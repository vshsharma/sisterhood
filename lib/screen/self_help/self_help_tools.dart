import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/self_help/self_help_tools_option.dart';

import '../../utill/dimension.dart';
import '../../utill/strings.dart';
import '../../utill/styles.dart';
import '../common/resource_button.dart';
import 'safety_plan_questions.dart';

class SelfHelpTools extends StatefulWidget {
  const SelfHelpTools({Key key}) : super(key: key);

  @override
  _SelfHelpToolsState createState() => _SelfHelpToolsState();
}

class _SelfHelpToolsState extends State<SelfHelpTools> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      Center(
        child: Padding(
          padding: const EdgeInsets.all(dim_20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  Strings.self_help_tools,
                  softWrap: true,
                  style: courierFont25W700Black,
                ),
                const SizedBox(height: dim_40),
                const Text(
                  Strings.self_help_tools_desc,
                  maxLines: null,
                  softWrap: true,
                  style: courierFont18W600,
                ),
                const SizedBox(height: dim_40),
                ResourceButton(
                  labelButton: Strings.creating_a_saafety_plan,
                  onButtonPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SelfHelpToolsOption()));
                  },
                ),
                ResourceButton(
                  labelButton: Strings.need_things_from_my_apartment,
                  onButtonPress: () {

                  },
                ),
                ResourceButton(
                  labelButton: Strings.my_partner_force_to_deb,
                  onButtonPress: () {

                  },
                ),
                ResourceButton(
                  labelButton: Strings.custody_of_child,
                  onButtonPress: () {

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
