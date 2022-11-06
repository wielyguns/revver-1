import 'package:flutter/material.dart';
import 'package:revver/globals.dart';

class RegularForm extends StatelessWidget {
  RegularForm(
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
          style: CustomFont.regular12,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: CustomFont.hint,
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.goldColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
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

// ignore: must_be_immutable
class PasswordForm extends StatefulWidget {
  PasswordForm(
      {Key key,
      this.title,
      this.hint,
      this.visible,
      this.controller,
      this.isValidator})
      : super(key: key);
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
          style: CustomFont.regular12,
          controller: widget.controller,
          obscureText: !widget.visible,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: CustomFont.hint,
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.goldColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                widget.visible ? Icons.visibility : Icons.visibility_off,
                color: CustomColor.goldColor,
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
  // ignore: prefer_const_constructors_in_immutables
  StringDropdown({Key key}) : super(key: key);

  @override
  State<StringDropdown> createState() => _StringDropdownState();
}

class _StringDropdownState extends State<StringDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items:
          ['Dog', 'Cat', 'Tiger', 'Lion'].map<DropdownMenuItem>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(
            value,
            style: CustomFont.filled,
          ),
        );
      }).toList(),
      onChanged: (value) {},
      dropdownColor: CustomColor.whiteColor,
      style: CustomFont.filled,
      decoration: InputDecoration(
        hintText: "Name",
        hintStyle: CustomFont.hint,
        contentPadding: EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: CustomColor.oldGreyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              width: 2, style: BorderStyle.solid, color: CustomColor.goldColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              width: 2, style: BorderStyle.solid, color: CustomColor.redColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              width: 2, style: BorderStyle.solid, color: CustomColor.redColor),
        ),
      ),
    );
  }
}