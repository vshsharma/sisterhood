import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:sisterhood_app/calculator/processor.dart';
import 'package:sisterhood_app/utill/app_constants.dart';

import '../screen/Dashboard/bottom_navigation_bar_page.dart';
import '../utill/sharedprefrence.dart';
import 'display.dart';
import 'key-controller.dart';
import 'key-pad.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output;

  @override
  void initState() {
    String personnel =
        SharedPrefManager.sharedPreferences.get(AppConstants.personnelCode);

    KeyController.listen((event) => Processor.process(event));
    Processor.listenEqual((_output) => setState(() {
          if (_output == "0") {
            return;
          } else if (personnel == "0") {
            SharedPrefManager.savePrefString(
                AppConstants.personnelCode, _output);
          }
          if (_output ==
              SharedPrefManager.sharedPreferences
                  .get(AppConstants.personnelCode)) {
            Get.to(const BottomNavigationPage(),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 600));
          }
        }));

    Processor.listen((data) => setState(() {
          _output = data;
        }));
    Processor.refresh();
    super.initState();
  }

  @override
  void dispose() {
    KeyController.dispose();
    Processor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    double buttonSize = screen.width / 4;
    double displayHeight = screen.height - (buttonSize * 5) - (buttonSize);

    return Scaffold(
      backgroundColor: const Color.fromARGB(196, 32, 64, 96),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Display(value: _output, height: displayHeight),
            KeyPad()
          ]),
    );
  }
}
