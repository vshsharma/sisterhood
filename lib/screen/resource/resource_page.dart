import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sisterhood_app/screen/self_help/emergency.dart';
import 'package:sisterhood_app/screen/self_help/legal_informtion.dart';
import 'package:sisterhood_app/screen/self_help/self_help_tools.dart';

import '../../utill/dimension.dart';
import '../../utill/images.dart';
import '../../utill/strings.dart';
import '../../utill/styles.dart';
import '../../web/web_view.dart';
import '../../web/web_view_local.dart';
import '../common/base_widget.dart';
import '../common/resource_button.dart';
import '../self_help/domestic_abuse.dart';
import '../self_help/need_support.dart';
import '../self_help/safety_plan_questions.dart';
import '../self_help/self_help_tools_option.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({Key key}) : super(key: key);

  @override
  _ResourcePageState createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(Center(
      child: Padding(
        padding: const EdgeInsets.all(dim_20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                Strings.resources,
                softWrap: true,
                style: courierFont25W700Black,
              ),
              const SizedBox(height: dim_40),
              ResourceButton(
                labelButton: Strings.cta_label_emergency,
                onButtonPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Emergecny(),
                    ),
                  );
                },
              ),
              ResourceButton(
                labelButton: Strings.cta_label_women_shelter,
                onButtonPress: () {
                  print('hit me');
                },
              ),
              ResourceButton(
                labelButton: Strings.cta_label_need_support,
                onButtonPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NeedSupport(),
                    ),
                  );
                },
              ),
              ResourceButton(
                labelButton: Strings.cta_label_legal_info,
                onButtonPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LegalInformation(),
                    ),
                  );
                },
              ),
              ResourceButton(
                labelButton: Strings.cta_label_more_about_abuse,
                onButtonPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DomesticAbuse(),
                    ),
                  );
                },
              ),
              ResourceButton(
                labelButton: Strings.cta_label_self_help_tool,
                onButtonPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SelfHelpToolsOption(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
