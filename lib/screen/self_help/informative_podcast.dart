import 'package:flutter/material.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';

import '../../utill/dimension.dart';
import '../../utill/strings.dart';
import '../../utill/styles.dart';
import '../common/custom_html_viewer.dart';
import '../common/grey_background_widget.dart';

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
          children: const [
            Text(
              Strings.informative_podcast,
              textAlign: TextAlign.center,
              softWrap: true,
              style: courierFont25W700Black,
            ),
            SizedBox(height: dim_20),
            Text(
              Strings.informative_podcast_desc,
              textAlign: TextAlign.center,
              maxLines: null,
              softWrap: true,
              style: courierFont18W400,
            ),
            SizedBox(height: dim_30),
            GreyBackgroundCard(
                child: CustomHTMLViewer(Strings.info_podcast_1)
            ),
            SizedBox(height: dim_30),
            GreyBackgroundCard(
                child: CustomHTMLViewer(Strings.info_podcast_2)
            ),
            SizedBox(height: dim_30),
            GreyBackgroundCard(
                child: CustomHTMLViewer(Strings.info_podcast_3)
            ),
            SizedBox(height: dim_30),
          ],
        ),
      ),
    ));
  }
}
