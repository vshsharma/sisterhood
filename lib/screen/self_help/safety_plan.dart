import 'package:flutter/material.dart';
import '../../utill/dimension.dart';
import '../../utill/strings.dart';
import '../../utill/styles.dart';
import '../common/resource_button.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';

import 'safety_plan_questions.dart';

class SafetyPlanScreen extends StatefulWidget {
  const SafetyPlanScreen({Key key}) : super(key: key);

  @override
  _SafetyPlanScreenState createState() => _SafetyPlanScreenState();
}

class _SafetyPlanScreenState extends State<SafetyPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(Padding(
      padding: const EdgeInsets.all(dim_20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                Strings.safety_plan,
                softWrap: true,
                style: courierFont25W700Black,
              ),
            ),
            const SizedBox(height: dim_40),
            const Text(
              Strings.safety_plan_desc,
              maxLines: null,
              softWrap: true,
              style: courierFont16W600,
            ),
            const SizedBox(height: dim_40),
            ResourceButton(
              labelButton: Strings.safety_planning,
              onButtonPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SafetyPlanQuestion()));
              },
            ),
            const SizedBox(height: dim_40),
            const Text(
              Strings.helpful_tips,
              maxLines: null,
              softWrap: true,
              style: courierFont18W600,
            ),
            const SizedBox(height: dim_20),
            const Padding(
              padding: EdgeInsets.all(dim_25),
              child: Text(
                Strings.helpful_tips_1,
                maxLines: null,
                softWrap: true,
                style: courierFont16W600,
              ),
            ),

          ],
        ),
      ),
    ),);
  }
}
