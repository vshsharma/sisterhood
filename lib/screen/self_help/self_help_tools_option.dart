import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/resource_button.dart';
import 'package:sisterhood_app/screen/self_help/guided_meditation.dart';
import 'package:sisterhood_app/screen/self_help/safety_plan.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/styles.dart';

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
              Text(
                AppLocalizations.of(context).self_help_tools,
                textAlign: TextAlign.center,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              const SizedBox(height: dim_40),
              Text(
                AppLocalizations.of(context).self_help_tools_desc,
                textAlign: TextAlign.center,
                maxLines: null,
                softWrap: true,
                style: courierFont18W400,
              ),
              const SizedBox(height: dim_40),
              ResourceButton(
                labelButton: AppLocalizations.of(context).safety_planning,
                onButtonPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SafetyPlanScreen()));
                },
              ),
              ResourceButton(
                labelButton: AppLocalizations.of(context).guided_meditation,
                onButtonPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const GuidedMeditation()));
                },
              ),
              ResourceButton(
                labelButton: AppLocalizations.of(context).informative_podcasts,
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
