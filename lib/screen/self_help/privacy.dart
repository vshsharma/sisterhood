import 'package:flutter/material.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';

import '../../utill/dimension.dart';
import '../../utill/strings.dart';
import '../../utill/styles.dart';
import '../common/custom_html_viewer.dart';
import '../common/grey_background_widget.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      Padding(
        padding: const EdgeInsets.all(dim_20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                Strings.sisterhood_privacy,
                textAlign: TextAlign.center,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              SizedBox(height: dim_40),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(Strings.privacy)
              ),
              SizedBox(height: dim_30),
            ],
          ),
        ),
      )
    );
  }
}
