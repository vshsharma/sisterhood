import 'package:flutter/material.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/grey_background_widget.dart';

import '../../utill/dimension.dart';
import '../../utill/strings.dart';
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
            children: const [
              Text(
                Strings.guided_meditations,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              SizedBox(height: dim_20),
              Text(
                Strings.guided_meditations_desc,
                maxLines: null,
                softWrap: true,
                style: courierFont18W400,
              ),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                child: CustomHTMLViewer(Strings.self_love_and_affirmations)
              ),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                child: CustomHTMLViewer(Strings.Stress_and_anxiety)
              ),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                child: CustomHTMLViewer(Strings.Grounding_exercises)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
