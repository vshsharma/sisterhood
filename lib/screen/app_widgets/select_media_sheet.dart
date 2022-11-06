import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/extension.dart';
import 'package:sisterhood_app/utill/styles.dart';

class SelectMediaSheet extends StatefulWidget {
  final Function cameraPress;
  final Function galleryPress;
  const SelectMediaSheet({Key key, this.cameraPress, this.galleryPress})
      : super(key: key);

  @override
  State<SelectMediaSheet> createState() => _SelectMediaSheetState();
}

class _SelectMediaSheetState extends State<SelectMediaSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          ListTile(
              leading: const Icon(
                Icons.photo_camera,
                size: 35,
              ),
              title: Text(
                context.loc.camera,
                style: courierFont18W600,
              ),
              onTap: widget.cameraPress),
          ListTile(
            leading: const Icon(
              Icons.photo_library,
              size: 35,
            ),
            title: Text(
              context.loc.gallery,
              style: courierFont18W600,
            ),
            onTap: widget.galleryPress,
          ),
        ],
      ),
    );
  }
}
