import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({Key key, this.title, this.func, this.color}) : super(key: key);
  final String title;
  final Function func;
  Color color;

  @override
  Widget build(BuildContext context) {
    color ??= CustomColor.brownColor;
    return CupertinoButton(
      onPressed: func,
      color: color,
      child: Text(
        title,
        style: CustomFont(CustomColor.whiteColor, 16, FontWeight.w600).font,
      ),
    );
  }
}

// ignore: must_be_immutable
class IconTextButton extends StatelessWidget {
  IconTextButton(
      {Key key,
      this.title,
      this.iconTitle,
      this.func,
      this.buttonColor,
      this.borderColor,
      this.textColor})
      : super(key: key);
  final String title;
  final String iconTitle;
  final Function func;
  Color buttonColor;
  Color borderColor;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    buttonColor ??= CustomColor.brownColor;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: (borderColor != null)
              ? Border.all(color: borderColor)
              : Border.all(width: 0, color: buttonColor)),
      child: CupertinoButton(
        onPressed: func,
        color: buttonColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (iconTitle != null)
                ? SvgPicture.asset("assets/svg/$iconTitle",
                    color: CustomColor.whiteColor)
                : SizedBox(),
            (iconTitle != null) ? SpacerWidth(w: 10) : SizedBox(),
            Text(
              title,
              style: CustomFont(
                      (textColor != null) ? textColor : CustomColor.whiteColor,
                      16,
                      FontWeight.w600)
                  .font,
            ),
          ],
        ),
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({Key key, this.title, this.func}) : super(key: key);
  final String title;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: CustomColor.brownColor),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          "Add To Cart",
          style: CustomFont(CustomColor.whiteColor, 12, FontWeight.w600).font,
        ),
      ),
      onTap: func,
    );
  }
}

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({Key key, this.title, this.func})
      : super(key: key);
  final String title;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: CustomColor.oldGreyColor),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Center(
          child: Text(
            title,
            style: CustomFont(CustomColor.whiteColor, 12, FontWeight.w400).font,
          ),
        ),
      ),
      onTap: func,
    );
  }
}

class AccountMenu extends StatelessWidget {
  const AccountMenu({Key key, this.title, this.iconTitle, this.func})
      : super(key: key);
  final String title;
  final String iconTitle;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: CustomColor.brownColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      "assets/svg/$iconTitle",
                      color: CustomColor.whiteColor,
                    ),
                  ),
                ),
                SpacerWidth(w: 20),
                Text(
                  title,
                  style: CustomFont(CustomColor.blackColor, 14, FontWeight.w600)
                      .font,
                )
              ],
            ),
            Icon(
              Icons.arrow_forward,
              size: 16,
              color: CustomColor.brownColor,
            )
          ],
        ),
      ),
    );
  }
}
