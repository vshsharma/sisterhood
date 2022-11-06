import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sisterhood_app/utill/app_constants.dart';

import '../../utill/dimension.dart';
import '../../utill/styles.dart';
import '../common/base_widget.dart';
import '../common/custom_html_viewer.dart';
import '../common/grey_background_widget.dart';

class NeedSupport extends StatefulWidget {
  const NeedSupport({Key key}) : super(key: key);

  @override
  State<NeedSupport> createState() => _NeedSupportState();
}

class _NeedSupportState extends State<NeedSupport> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      Padding(
        padding: const EdgeInsets.all(dim_20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context).need_support_title,
                textAlign: TextAlign.center,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              const SizedBox(height: dim_20),
              Text(
                AppLocalizations.of(context).need_support_desc,
                textAlign: TextAlign.center,
                maxLines: null,
                softWrap: true,
                style: courierFont18W400,
              ),
              const SizedBox(height: dim_30),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(AppLocalizations.of(context)
                      .support_p1(AppConstants.supportP1))),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(
                      AppLocalizations.of(context).support_p2)),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(AppLocalizations.of(context)
                      .support_p3(AppConstants.supportP3))),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(AppLocalizations.of(context)
                      .support_p4(AppConstants.supportP4))),
              // SizedBox(height: dim_30),
              // GreyBackgroundCard(
              //     child: CustomHTMLViewer(Strings.support_p5)
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
