import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/styles.dart';

import '../../utill/strings.dart';

class CustomSlider extends StatefulWidget {
  double value;
  CustomSlider(this.value, {Key key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  String _status;

  Color _statusColor;

  @override
  void initState() {
    super.initState();
    _status = '${widget.value.round()}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(dim_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Slider(
            min: 0.0,
            max: 1000.0,
            value: widget.value,
            divisions: 50,
            onChanged: (value) {
              setState(() {
                widget.value = value;
                _status = '${widget.value.round()}';
              });
            },
            onChangeStart: (value) {
              setState(() {
                widget.value = value;
                _status = '${widget.value.round()}';
              });
            },
            onChangeEnd: (value) {
              setState(() {
                widget.value = value;
                _status = '${widget.value.round()}';
              });
            },
          ),
          Text(
            '${Strings.distance} : $_status',
            style: courierFont18W400,
          ),
        ],
      ),
    );
  }
}
