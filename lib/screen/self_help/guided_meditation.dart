import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/grey_background_widget.dart';
import 'package:sisterhood_app/utill/app_constants.dart';

import '../../utill/dimension.dart';
import '../../utill/styles.dart';
import '../common/custom_html_viewer.dart';

class GuidedMeditation extends StatefulWidget {
  const GuidedMeditation({Key key}) : super(key: key);

  @override
  _GuidedMeditationState createState() => _GuidedMeditationState();
}

class _GuidedMeditationState extends State<GuidedMeditation> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      Padding(
        padding: const EdgeInsets.all(dim_20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context).guided_meditations,
                textAlign: TextAlign.center,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              const SizedBox(height: dim_20),
              Text(
                AppLocalizations.of(context).guided_meditations_desc,
                textAlign: TextAlign.center,
                maxLines: null,
                softWrap: true,
                style: courierFont18W400,
              ),
              const SizedBox(height: dim_30),
              GreyBackgroundCard(
                child: CustomHTMLViewer(
                  AppLocalizations.of(context).self_love_and_affirmations(
                    AppConstants.guided_url1,
                    AppConstants.guided_url2,
                  ),
                ),
              ),
              const SizedBox(height: dim_30),
              GreyBackgroundCard(
                child: CustomHTMLViewer(
                  AppLocalizations.of(context).stress_and_anxiety(
                      AppConstants.guided_url3,
                      AppConstants.guided_url4,
                      AppConstants.guided_url5),
                ),
              ),
              const SizedBox(height: dim_30),
              GreyBackgroundCard(
                child: CustomHTMLViewer(
                  AppLocalizations.of(context).grounding_exercises(
                    AppConstants.guided_url6,
                    AppConstants.guided_url7,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
