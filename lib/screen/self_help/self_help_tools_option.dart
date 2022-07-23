import 'package:flutter/material.dart';
import 'package:sisterhood_app/screen/self_help/guided_meditation.dart';
import 'package:sisterhood_app/screen/self_help/safety_plan.dart';
import '../../utill/dimension.dart';
import '../../utill/strings.dart';
import '../../utill/styles.dart';
import '../common/resource_button.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';

import 'informative_podcast.dart';

class SelfHelpToolsOption extends StatefulWidget {
  const SelfHelpToolsOption({Key key}) : super(key: key);

  @override
  _SelfHelpToolsOptionState createState() => _SelfHelpToolsOptionState();
}

class _SelfHelpToolsOptionState extends State<SelfHelpToolsOption> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      Padding(
        padding: const EdgeInsets.all(dim_20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                Strings.self_help_tools,
                textAlign: TextAlign.center,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              const SizedBox(height: dim_40),
              const Text(
                Strings.self_help_tools_desc,
                textAlign: TextAlign.center,
                maxLines: null,
                softWrap: true,
                style: courierFont18W400,
              ),
              const SizedBox(height: dim_40),
              ResourceButton(
                labelButton: Strings.safety_planning,
                onButtonPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SafetyPlanScreen()));
                },
              ),
              ResourceButton(
                labelButton: Strings.guided_meditation,
                onButtonPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const GuidedMeditation()));
                 },
              ),
              ResourceButton(
                labelButton: Strings.informative_podcasts,
                onButtonPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InformativePodcast()));
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
