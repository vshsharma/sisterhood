import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/custom_html_viewer.dart';
import 'package:sisterhood_app/screen/common/grey_background_widget.dart';
import 'package:sisterhood_app/utill/app_constants.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/styles.dart';

class DomesticAbuse extends StatefulWidget {
  const DomesticAbuse({Key key}) : super(key: key);

  @override
  State<DomesticAbuse> createState() => _DomesticAbuseState();
}

class _DomesticAbuseState extends State<DomesticAbuse> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(Padding(
      padding: const EdgeInsets.all(dim_20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).domestic_abuse,
              textAlign: TextAlign.center,
              softWrap: true,
              style: courierFont25W700Black,
            ),
            const SizedBox(height: dim_40),
            GreyBackgroundCard(
              child: CustomHTMLViewer(
                AppLocalizations.of(context).domestic_content(
                    AppConstants.domesticAbuseUrl1,
                    AppConstants.domesticAbuseUrl2,
                    AppConstants.domesticAbuseUrl3,
                    AppConstants.domesticAbuseUrl4),
              ),
            ),
            const SizedBox(height: dim_30),
          ],
        ),
      ),
    ));
  }
}
