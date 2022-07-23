import 'package:flutter/material.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';

import '../../utill/dimension.dart';
import '../../utill/strings.dart';
import '../../utill/styles.dart';
import '../common/custom_html_viewer.dart';
import '../common/grey_background_widget.dart';

class DomesticAbuse extends StatefulWidget {
  const DomesticAbuse({Key key}) : super(key: key);

  @override
  State<DomesticAbuse> createState() => _DomesticAbuseState();
}

class _DomesticAbuseState extends State<DomesticAbuse> {
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
                Strings.domestic_abuse,
                textAlign: TextAlign.center,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              SizedBox(height: dim_40),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(Strings.domestic_content)
              ),
              SizedBox(height: dim_30),
            ],
          ),
        ),
      )
    );
  }
}
