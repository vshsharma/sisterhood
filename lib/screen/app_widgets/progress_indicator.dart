import 'package:flutter/material.dart';

import '../../utill/dimension.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
            Container(
                margin: const EdgeInsets.all(dim_8),
                child: const Text("Loading...")),
          ]),
    );
  }
}
