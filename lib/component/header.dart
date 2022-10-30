import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomHeader extends StatelessWidget with PreferredSizeWidget {
  CustomHeader({Key key, this.isPop}) : super(key: key);
  bool isPop;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      leading:
          (isPop) ? const CupertinoNavigationBarBackButton() : const SizedBox(),
      middle: const Text("data"),
      trailing: const Icon(Icons.abc),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
