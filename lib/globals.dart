import 'package:flutter/material.dart';

class CustomColor {
  static Color blackColor = const Color(0xff000000);
  static Color goldColor = const Color(0xffF0A500);
  static Color brownColor = const Color(0xffCF7500);
  static Color oldGreyColor = const Color(0xffA7A7A7);
  static Color greyColor = const Color(0xffDBDBDB);
  static Color whiteColor = const Color(0xffFAFAFA);
  static Color purpleColor = const Color(0xffBB6BD9);
  static Color blueColor = const Color(0xff2D9CDB);
  static Color redColor = const Color(0xffFF0000);
}

class CustomFont {
  //Heading
  static TextStyle heading48 = const TextStyle(
      fontSize: 48, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading36 = const TextStyle(
      fontSize: 36, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading24 = const TextStyle(
      fontSize: 24, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading18 = const TextStyle(
      fontSize: 18, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading16 = const TextStyle(
      fontSize: 16, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading12 = const TextStyle(
      fontSize: 12, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  static TextStyle heading10 = const TextStyle(
      fontSize: 10, fontFamily: "Montserrat", fontWeight: FontWeight.w700);
  //Bold
  static TextStyle bold48 = const TextStyle(
      fontSize: 48, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold36 = const TextStyle(
      fontSize: 36, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold24 = const TextStyle(
      fontSize: 24, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold18 = const TextStyle(
      fontSize: 18, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold16 = const TextStyle(
      fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold12 = const TextStyle(
      fontSize: 12, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  static TextStyle bold10 = const TextStyle(
      fontSize: 10, fontFamily: "Poppins", fontWeight: FontWeight.w700);
  //Medium
  static TextStyle medium48 = const TextStyle(
      fontSize: 48, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium36 = const TextStyle(
      fontSize: 36, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium24 = const TextStyle(
      fontSize: 24, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium18 = const TextStyle(
      fontSize: 18, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium16 = const TextStyle(
      fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium12 = const TextStyle(
      fontSize: 12, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  static TextStyle medium10 = const TextStyle(
      fontSize: 10, fontFamily: "Poppins", fontWeight: FontWeight.w500);
  //Regular
  static TextStyle regular48 =
      const TextStyle(fontSize: 48, fontFamily: "Poppins");
  static TextStyle regular36 =
      const TextStyle(fontSize: 36, fontFamily: "Poppins");
  static TextStyle regular24 =
      const TextStyle(fontSize: 24, fontFamily: "Poppins");
  static TextStyle regular18 =
      const TextStyle(fontSize: 18, fontFamily: "Poppins");
  static TextStyle regular16 =
      const TextStyle(fontSize: 16, fontFamily: "Poppins");
  static TextStyle regular12 =
      const TextStyle(fontSize: 12, fontFamily: "Poppins");
  static TextStyle regular10 =
      const TextStyle(fontSize: 10, fontFamily: "Poppins");
  //Hint
  static TextStyle hint = TextStyle(
      fontSize: 12, fontFamily: "Poppins", color: CustomColor.oldGreyColor);
  //Sub Heading
  static TextStyle subheading = TextStyle(
      fontSize: 12, fontFamily: "Poppins", color: CustomColor.oldGreyColor);
  //Link
  static TextStyle link = TextStyle(
      fontSize: 12, fontFamily: "Poppins", color: CustomColor.goldColor);
}
