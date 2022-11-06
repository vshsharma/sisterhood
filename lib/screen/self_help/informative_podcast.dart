import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/screen/common/custom_html_viewer.dart';
import 'package:sisterhood_app/screen/common/grey_background_widget.dart';
import 'package:sisterhood_app/utill/app_constants.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/styles.dart';

class InformativePodcast extends StatefulWidget {
  const InformativePodcast({Key key}) : super(key: key);

  @override
  State<InformativePodcast> createState() => _InformativePodcastState();
}

class _InformativePodcastState extends State<InformativePodcast> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(Padding(
      padding: const EdgeInsets.all(dim_20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context).informative_podcast,
              textAlign: TextAlign.center,
              softWrap: true,
              style: courierFont25W700Black,
            ),
            SizedBox(height: dim_20),
            Text(
              AppLocalizations.of(context).informative_podcast_desc,
              textAlign: TextAlign.center,
              maxLines: null,
              softWrap: true,
              style: courierFont18W400,
            ),
            const SizedBox(height: dim_30),
            GreyBackgroundCard(
              child: CustomHTMLViewer(
                AppLocalizations.of(context)
                    .info_podcast_1(AppConstants.podcast_url1),
              ),
            ),
            const SizedBox(height: dim_30),
            GreyBackgroundCard(
              child: CustomHTMLViewer(
                AppLocalizations.of(context)
                    .info_podcast_2(AppConstants.podcast_url2),
              ),
            ),
            const SizedBox(height: dim_30),
            GreyBackgroundCard(
              child: CustomHTMLViewer(
                AppLocalizations.of(context)
                    .info_podcast_3(AppConstants.podcast_url3),
              ),
            ),
            SizedBox(height: dim_30),
          ],
        ),
      ),
    ));
  }
}
