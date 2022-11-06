import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/custom_html_viewer.dart';
import 'package:sisterhood_app/screen/common/grey_background_widget.dart';
import 'package:sisterhood_app/utill/app_constants.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/styles.dart';

class Emergecny extends StatefulWidget {
  const Emergecny({Key key}) : super(key: key);

  @override
  State<Emergecny> createState() => _EmergecnyState();
}

class _EmergecnyState extends State<Emergecny> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(Padding(
      padding: const EdgeInsets.all(dim_20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context).emergency_title,
              textAlign: TextAlign.center,
              softWrap: true,
              style: courierFont25W700Black,
            ),
            const SizedBox(height: dim_40),
            GreyBackgroundCard(
                child: CustomHTMLViewer(AppLocalizations.of(context)
                    .have_an_emergency(AppConstants.emergencyUrl))),
            const SizedBox(height: dim_30),
          ],
        ),
      ),
    ));
  }
}
