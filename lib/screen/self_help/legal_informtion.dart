import 'package:flutter/material.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';

import '../../utill/dimension.dart';
import '../../utill/strings.dart';
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
    return BaseWidget(
      Padding(
        padding: const EdgeInsets.all(dim_20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                Strings.good_to_have_legal_info,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              SizedBox(height: dim_20),
              Text(
                Strings.good_to_have_legal_info_desc,
                maxLines: null,
                softWrap: true,
                style: courierFont18W400,
              ),
              SizedBox(height: dim_30),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(Strings.legal_info_content)
              ),
              SizedBox(height: dim_30),
            ],
          ),
        ),
      )
    );
  }
}
