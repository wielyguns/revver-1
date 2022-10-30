import 'package:flutter/cupertino.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  CustomButton({Key key, this.title, this.func}) : super(key: key);
  String title;
  Function func;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: widget.func,
      color: CustomColor.goldColor,
      child: Text(
        widget.title,
        style: CustomFont.regular12,
      ),
    );
  }
}
