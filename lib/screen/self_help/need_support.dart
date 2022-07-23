import 'package:flutter/material.dart';

import '../../utill/dimension.dart';
import '../../utill/strings.dart';
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
            children: const [
              Text(
                Strings.need_support_title,
                textAlign: TextAlign.center,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              SizedBox(height: dim_20),
              Text(
                Strings.need_support_desc,
                textAlign: TextAlign.center,
                maxLines: null,
                softWrap: true,
                style: courierFont18W400,
              ),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(Strings.support_p1)
              ),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(Strings.support_p2)
              ),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(Strings.support_p3)
              ),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(Strings.support_p4)
              ),
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
