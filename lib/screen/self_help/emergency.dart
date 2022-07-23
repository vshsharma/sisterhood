import 'package:flutter/material.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';

import '../../utill/dimension.dart';
import '../../utill/strings.dart';
import '../../utill/styles.dart';
import '../common/custom_html_viewer.dart';
import '../common/grey_background_widget.dart';

class Emergecny extends StatefulWidget {
  const Emergecny({Key key}) : super(key: key);

  @override
  State<Emergecny> createState() => _EmergecnyState();
}

class _EmergecnyState extends State<Emergecny> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      Padding(
        padding: const EdgeInsets.all(dim_20),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text(
                Strings.emergency_title,
                textAlign: TextAlign.center,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              SizedBox(height: dim_40),
              GreyBackgroundCard(
                  child: CustomHTMLViewer(Strings.have_an_emergency)
              ),
              SizedBox(height: dim_30),
            ],
          ),
        ),
      )
    );
  }
}
