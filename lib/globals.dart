import 'package:flutter/material.dart';

class CustomScreen {
  BuildContext context;
  CustomScreen(this.context) : assert(context != null);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

class CustomColor {
  static Color blackColor = Color(0xff000000);
  static Color goldColor = Color(0xffF0A500);
  static Color brownColor = Color(0xffCF7500);
  static Color oldGreyColor = Color(0xffA7A7A7);
  static Color greyColor = Color(0xffDBDBDB);
  static Color whiteColor = Color(0xffFAFAFA);
  static Color purpleColor = Color(0xffBB6BD9);
  static Color blueColor = Color(0xff2D9CDB);
  static Color redColor = Color(0xffFF0000);
  static Color greenColor = Color(0xff8FFF00);
}

class CustomFont {
  //Heading
  static TextStyle heading48 = TextStyle(
      fontSize: 48, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading36 = TextStyle(
      fontSize: 36, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading24 = TextStyle(
      fontSize: 24, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading18 = TextStyle(
      fontSize: 18, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading16 = TextStyle(
      fontSize: 16, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading12 = TextStyle(
      fontSize: 12, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading10 = TextStyle(
      fontSize: 10, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  //Bold
  static TextStyle bold48 = TextStyle(
      fontSize: 48, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold36 = TextStyle(
      fontSize: 36, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold24 = TextStyle(
      fontSize: 24, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold18 = TextStyle(
      fontSize: 18, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold16 = TextStyle(
      fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold12 = TextStyle(
      fontSize: 12, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold10 = TextStyle(
      fontSize: 10, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  //Medium
  static TextStyle medium48 = TextStyle(
      fontSize: 48, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium36 = TextStyle(
      fontSize: 36, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium24 = TextStyle(
      fontSize: 24, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium18 = TextStyle(
      fontSize: 18, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium16 = TextStyle(
      fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium12 = TextStyle(
      fontSize: 12, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium10 = TextStyle(
      fontSize: 10, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  //Regular
  static TextStyle regular48 = TextStyle(fontSize: 48, fontFamily: "Poppins");
  static TextStyle regular36 = TextStyle(fontSize: 36, fontFamily: "Poppins");
  static TextStyle regular24 = TextStyle(fontSize: 24, fontFamily: "Poppins");
  static TextStyle regular18 = TextStyle(fontSize: 18, fontFamily: "Poppins");
  static TextStyle regular16 = TextStyle(fontSize: 16, fontFamily: "Poppins");
  static TextStyle regular12 = TextStyle(fontSize: 12, fontFamily: "Poppins");
  static TextStyle regular10 = TextStyle(fontSize: 10, fontFamily: "Poppins");
  //Hint
  static TextStyle hint = TextStyle(
      fontSize: 12, fontFamily: "Poppins", color: CustomColor.oldGreyColor);
  //Filled
  static TextStyle filled = TextStyle(
      fontSize: 12, fontFamily: "Poppins", color: CustomColor.blackColor);
  //Sub Heading
  static TextStyle subheading = TextStyle(
      fontSize: 12, fontFamily: "Poppins", color: CustomColor.oldGreyColor);
  //Link
  static TextStyle link = TextStyle(
      fontSize: 12, fontFamily: "Poppins", color: CustomColor.goldColor);
  //Link
  static TextStyle badge = TextStyle(
      fontSize: 8, fontFamily: "Poppins", color: CustomColor.whiteColor);
  //Widget Title
  static TextStyle widgetTitle = TextStyle(
      fontSize: 16,
      fontFamily: "Poppins",
      color: CustomColor.blackColor,
      fontWeight: FontWeight.w700);
  //AddToCart Button Text
  static TextStyle addToCart = TextStyle(
      fontSize: 12, fontFamily: "Poppins", color: CustomColor.whiteColor);
  //Change Password Button Text
  static TextStyle changePassword = TextStyle(
      fontSize: 10, fontFamily: "Poppins", color: CustomColor.whiteColor);
  //Card News Author
  static TextStyle newsAuthor = TextStyle(
      fontSize: 8, fontFamily: "Poppins", color: CustomColor.goldColor);
  //Card News Date
  static TextStyle newsDate = TextStyle(
      fontSize: 8, fontFamily: "Poppins", color: CustomColor.oldGreyColor);
//Tabbar Header
  static TextStyle tabbarHeading = TextStyle(
      fontSize: 18,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w700,
      color: CustomColor.blackColor);
}
