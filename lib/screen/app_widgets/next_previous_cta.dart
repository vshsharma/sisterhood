import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/extension.dart';

import '../../utill/dimension.dart';
import '../../utill/styles.dart';

class NextPreviousCTA extends StatelessWidget {
  const NextPreviousCTA({
    Key key,
    @required this.showBottomCTA,
    @required this.previousBtnCallback,
    @required this.nextBtnCallback,
  }) : super(key: key);

  final bool showBottomCTA;
  final Function previousBtnCallback;
  final Function nextBtnCallback;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showBottomCTA,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: dim_10, vertical: dim_5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: dim_5, horizontal: dim_10),
                  child: Text(context.loc.previous, style: courierFont18W600),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(dim_18),
                            side: const BorderSide(color: Colors.red)))),
                onPressed: previousBtnCallback,
              ),
            ),
            SizedBox(
              width: dim_10,
            ),
            Expanded(
              child: TextButton(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: dim_5, horizontal: dim_10),
                  child: Text(
                    context.loc.next,
                    style: courierFont18W600,
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(dim_18),
                            side: const BorderSide(color: Colors.red)))),
                onPressed: nextBtnCallback,
              ),
            )
          ],
        ),
      ),
    );
  }
}
