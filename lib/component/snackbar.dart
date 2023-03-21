import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revver/globals.dart';

void customSnackBar(
  BuildContext context,
  bool isDanger,
  String title,
) {
  var snackBar = SnackBar(
    content: Text(
      title,
      style: CustomFont.regular12,
    ),
    duration: Duration(milliseconds: 1500),
    backgroundColor: (isDanger) ? CustomColor.redColor : CustomColor.blueColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void onLoading(
  BuildContext context,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Container(
        height: CustomScreen(context).height,
        width: CustomScreen(context).width,
        color: Colors.black.withOpacity(0.1),
        child: Center(child: CupertinoActivityIndicator()),
      );
    },
  );
}
