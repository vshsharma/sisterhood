import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/extension.dart';
import 'package:sisterhood_app/utill/styles.dart';

import '../../utill/color_resources.dart';

class CustomSlider extends StatefulWidget {
  final Function update;
  double initialValue;
  CustomSlider(this.initialValue, this.update, {Key key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  String _status;
  double _value;
  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _status = '${_value.round()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: ColorResources.darkgrey)),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: dim_5, horizontal: dim_10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${context.loc.distance} : $_status ${context.loc.metre}',
                  style: courierFont16W600,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  onPressed: () {
                    widget.update(_value);
                  },
                  child: Text(
                    context.loc.update,
                    style: courierFont20W600,
                  ),
                )
              ],
            ),
            Slider(
              min: dim_0,
              max: dim_90000,
              value: _value,
              divisions: ten_thousand,
              onChanged: (value) {
                updateValue(value);
              },
              onChangeStart: (value) {
                updateValue(value);
              },
              onChangeEnd: (value) {
                updateValue(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  void updateValue(double value) {
    _value = value;
    setState(() {
      widget.initialValue = value;
      _status = '${_value.round()}';
    });
  }
}
