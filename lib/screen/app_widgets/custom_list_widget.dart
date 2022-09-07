import 'package:file_picker/file_picker.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimension.dart';
import '../../utill/styles.dart';

class CustomListWidget extends StatelessWidget {
  final List<PlatformFile> selectedMedia;
  const CustomListWidget(
    this.selectedMedia, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: selectedMedia.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  selectedMedia[index].name,
                  style: courierFont14W600ProfileHintColor,
                ),
              ),
              Text(
                filesize(selectedMedia[index].size),
                style: courierFont12W600ProfileHintColor,
              ),
            ],
          ),
          subtitle: Container(
            width: dim_100,
            height: dim_1,
            color: ColorResources.black,
          ),
        );
      },
    );
  }
}
