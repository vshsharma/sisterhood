import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/extension.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimension.dart';

class AddMediaView extends StatefulWidget {
  final Function onPress;
  final IconData icon;
  final String label;
  const AddMediaView(
      {Key key, this.onPress, this.icon = Icons.image, this.label = ''})
      : super(key: key);

  @override
  State<AddMediaView> createState() => _AddMediaViewState();
}

class _AddMediaViewState extends State<AddMediaView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(dim_8),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: ColorResources.box_border,
              width: dim_2,
            ),
            color: ColorResources.box_background,
            borderRadius: BorderRadius.circular(dim_20)),
        child: TextButton(
          onPressed: widget.onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(widget.icon),
              Text((widget.label != null || widget.label.isNotEmpty)
                  ? widget.label
                  : context.loc.add_picture),
            ],
          ),
        ),
      ),
    );
  }
}
