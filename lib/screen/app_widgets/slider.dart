import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/styles.dart';

import '../../utill/strings.dart';

class CustomSlider extends StatefulWidget {
  final Function update;
  const CustomSlider(this.update, {Key key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  String _status;
  double _value = 20000.0;
  @override
  void initState() {
    super.initState();
    _status = '${_value.round()}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: dim_5, horizontal: dim_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${Strings.distance} : $_status ${Strings.metre}',
                style: courierFont16W600,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                onPressed: () {
                  widget.update(_value);
                },
                child: const Text(
                  Strings.update,
                  style: courierFont20W600,
                ),
              )
            ],
          ),
          Slider(
            min: dim_0,
            max: dim_40000,
            value: _value,
            divisions: thousand,
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
    );
  }

  void updateValue(double value) {
    _value = value;
    setState(() {
      _status = '${_value.round()}';
    });
  }
}
