// ignore_for_file: must_be_immutable

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revver/globals.dart';
import 'package:intl/intl.dart';

class RegularForm extends StatelessWidget {
  RegularForm(
      {Key key,
      this.icon,
      this.title,
      this.hint,
      this.controller,
      this.isValidator,
      this.keyboardType,
      this.readOnly})
      : super(key: key);
  String icon;
  final String title;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isValidator;
  bool readOnly;

  @override
  Widget build(BuildContext context) {
    readOnly ??= false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomFont.regular12),
        SizedBox(height: 10),
        TextFormField(
          readOnly: readOnly,
          keyboardType: keyboardType,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: (icon == null)
                ? null
                : SvgPicture.asset(
                    icon,
                    width: 28,
                    height: 28,
                    fit: BoxFit.scaleDown,
                    color: CustomColor.brownColor,
                  ),
            hintText: hint,
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(15),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
          validator: (value) {
            if (isValidator) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $title';
              }
              return null;
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

class MultiLineForm extends StatelessWidget {
  MultiLineForm(
      {Key key,
      this.title,
      this.hint,
      this.controller,
      this.isValidator,
      this.keyboardType})
      : super(key: key);
  final String title;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomFont.regular12),
        SizedBox(height: 10),
        TextFormField(
          keyboardType: keyboardType,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          maxLines: 5,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
          validator: (value) {
            if (isValidator) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $title';
              }
              return null;
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

class PasswordForm extends StatefulWidget {
  PasswordForm(
      {Key key,
      this.icon,
      this.title,
      this.hint,
      this.visible,
      this.controller,
      this.isValidator})
      : super(key: key);
  String icon;
  final String title;
  final String hint;
  bool visible;
  final TextEditingController controller;
  final bool isValidator;

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  @override
  Widget build(BuildContext context) {
    String tit = widget.title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: CustomFont.regular12),
        SizedBox(height: 10),
        TextFormField(
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          controller: widget.controller,
          obscureText: !widget.visible,
          decoration: InputDecoration(
            prefixIcon: (widget.icon == null)
                ? null
                : SvgPicture.asset(
                    widget.icon,
                    width: 28,
                    height: 28,
                    fit: BoxFit.scaleDown,
                    color: CustomColor.brownColor,
                  ),
            hintText: widget.hint,
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(15),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                widget.visible ? Icons.visibility : Icons.visibility_off,
                color: CustomColor.brownColor,
              ),
              onPressed: () {
                setState(() {
                  widget.visible = !widget.visible;
                });
              },
            ),
          ),
          validator: (value) {
            if (widget.isValidator) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $tit';
              }
              return null;
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}

class StringDropdown extends StatefulWidget {
  StringDropdown(
      {Key key,
      this.list,
      this.title,
      this.hint,
      this.value,
      this.callback,
      this.icon})
      : super(key: key);
  List<String> list;
  String title;
  String hint;
  String value;
  Function(String val) callback;
  String icon;

  @override
  State<StringDropdown> createState() => _StringDropdownState();
}

class _StringDropdownState extends State<StringDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: CustomFont.regular12),
        SizedBox(height: 10),
        DropdownButtonFormField(
          value: widget.value,
          items: widget.list.map<DropdownMenuItem>((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400)
                    .font,
              ),
            );
          }).toList(),
          onChanged: (value) {
            // print(value);
            widget.callback(value);
          },
          dropdownColor: CustomColor.whiteColor,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: (widget.icon == null)
                ? null
                : SvgPicture.asset(
                    widget.icon,
                    width: 28,
                    height: 28,
                    fit: BoxFit.scaleDown,
                    color: CustomColor.brownColor,
                  ),
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(15),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
        ),
      ],
    );
  }
}

class DynamicDropdown extends StatelessWidget {
  DynamicDropdown({Key key, this.hint, this.list, this.title, this.callback})
      : super(key: key);
  String title;
  String hint;
  List list;
  Function(String val) callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomFont.regular12),
        SizedBox(height: 10),
        DropdownButtonFormField(
          items: list.map((val) {
            return DropdownMenuItem(
              value: val,
              child: Text(
                val.name,
                style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400)
                    .font,
              ),
            );
          }).toList(),
          onChanged: (val) {
            callback(val.id);
          },
          dropdownColor: CustomColor.whiteColor,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(15),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
        ),
      ],
    );
  }
}

class SearchForm extends StatelessWidget {
  SearchForm({Key key, this.controller, this.callback}) : super(key: key);
  TextEditingController controller;
  VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CustomColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 13,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
        controller: controller,
        decoration: InputDecoration(
          fillColor: CustomColor.whiteColor,
          suffixIcon: (controller.text != "")
              ? IconButton(
                  onPressed: (() {
                    controller.clear();
                    callback();
                    FocusScope.of(context).unfocus();
                  }),
                  icon: Icon(
                    Icons.clear,
                    color: CustomColor.brownColor,
                  ),
                )
              : IconButton(
                  onPressed: (() {
                    callback();
                    FocusScope.of(context).unfocus();
                  }),
                  icon: Icon(
                    Icons.search,
                    color: CustomColor.brownColor,
                  ),
                ),
          hintText: "Search",
          hintStyle:
              CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: CustomColor.whiteColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: CustomColor.whiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: CustomColor.whiteColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: CustomColor.whiteColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: CustomColor.whiteColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: CustomColor.whiteColor),
          ),
        ),
        onEditingComplete: () {
          callback();
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}

class DateTimeOnlyPickerForm extends StatefulWidget {
  DateTimeOnlyPickerForm(
      {Key key, this.title, this.hint, this.date, this.callback, this.icon})
      : super(key: key);
  final String title;
  final String hint;
  String icon;
  DateTime date;
  final Function(DateTime) callback;

  @override
  State<DateTimeOnlyPickerForm> createState() => _DateTimeOnlyPickerFormState();
}

class _DateTimeOnlyPickerFormState extends State<DateTimeOnlyPickerForm> {
  String dateString;
  @override
  void initState() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(widget.date);
    setState(() {
      dateString = formatted;
    });
    // print(formatted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: CustomFont.regular12),
        SizedBox(height: 10),
        TextFormField(
          readOnly: true,
          onTap: () => _showDialog(),
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          decoration: InputDecoration(
            hintText: dateString,
            prefixIcon: (widget.icon == null)
                ? null
                : SvgPicture.asset(
                    widget.icon,
                    width: 28,
                    height: 28,
                    fit: BoxFit.scaleDown,
                    color: CustomColor.brownColor,
                  ),
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(15),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
        ),
      ],
    );
  }

  _showDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        color: CustomColor.whiteColor,
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: widget.date,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                widget.date = newDate;
                widget.callback(newDate);
              });
            },
          ),
        ),
      ),
    );
  }
}

class DateTimePickerForm extends StatefulWidget {
  DateTimePickerForm(
      {Key key, this.title, this.hint, this.date, this.callback, this.icon})
      : super(key: key);
  final String title;
  final String hint;
  String icon;
  DateTime date;
  final Function(DateTime) callback;

  @override
  State<DateTimePickerForm> createState() => _DateTimePickerFormState();
}

class _DateTimePickerFormState extends State<DateTimePickerForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: CustomFont.regular12),
        SizedBox(height: 10),
        TextFormField(
          readOnly: true,
          onTap: () => _showDialog(),
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          decoration: InputDecoration(
            hintText: widget.date.toString(),
            prefixIcon: (widget.icon == null)
                ? null
                : SvgPicture.asset(
                    widget.icon,
                    width: 28,
                    height: 28,
                    fit: BoxFit.scaleDown,
                    color: CustomColor.brownColor,
                  ),
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(15),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
        ),
      ],
    );
  }

  _showDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        color: CustomColor.whiteColor,
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: widget.date,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                widget.date = newDate;
                widget.callback(newDate);
              });
            },
          ),
        ),
      ),
    );
  }
}

class CurrencyForm extends StatelessWidget {
  CurrencyForm(
      {Key key,
      this.icon,
      this.title,
      this.hint,
      this.formValue,
      this.controller,
      this.isValidator,
      this.keyboardType,
      this.callback,
      this.readOnly})
      : super(key: key);
  String icon;
  final String title;
  final String hint;
  String formValue;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isValidator;
  bool readOnly;
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    decimalDigits: 0,
    symbol: 'Rp ',
  );
  final Function(String) callback;

  @override
  Widget build(BuildContext context) {
    readOnly ??= false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomFont.regular12),
        SizedBox(height: 10),
        TextFormField(
          readOnly: readOnly,
          keyboardType: keyboardType,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          initialValue: _formatter.format(formValue),
          inputFormatters: <TextInputFormatter>[_formatter],
          onChanged: (val) {
            callback(val);
          },
          decoration: InputDecoration(
            prefixIcon: (icon == null)
                ? null
                : SvgPicture.asset(
                    icon,
                    width: 28,
                    height: 28,
                    fit: BoxFit.scaleDown,
                    color: CustomColor.brownColor,
                  ),
            hintText: hint,
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(15),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
          validator: (value) {
            if (isValidator) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $title';
              }
              return null;
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
