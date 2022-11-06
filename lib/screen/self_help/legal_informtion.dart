import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/utill/app_constants.dart';

import '../../utill/dimension.dart';
import '../../utill/styles.dart';
import '../common/custom_html_viewer.dart';
import '../common/grey_background_widget.dart';

class LegalInformation extends StatefulWidget {
  const LegalInformation({Key key}) : super(key: key);

  @override
  State<LegalInformation> createState() => _LegalInformationState();
}

class _LegalInformationState extends State<LegalInformation> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(Padding(
      padding: const EdgeInsets.all(dim_20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).good_to_have_legal_info,
              textAlign: TextAlign.center,
              softWrap: true,
              style: courierFont25W700Black,
            ),
            const SizedBox(height: dim_20),
            Text(
              AppLocalizations.of(context).good_to_have_legal_info_desc,
              textAlign: TextAlign.center,
              maxLines: null,
              softWrap: true,
              style: courierFont18W400,
            ),
            const SizedBox(height: dim_30),
            GreyBackgroundCard(
                child: CustomHTMLViewer(AppLocalizations.of(context)
                    .legal_info_content(
                        AppConstants.legalInfoUrl1,
                        AppConstants.legalInfoUrl1,
                        AppConstants.legalInfoAsset))),
            const SizedBox(height: dim_30),
          ],
        ),
      ),
    ));
  }
}
