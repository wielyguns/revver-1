import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class SetDream extends StatefulWidget {
  const SetDream({Key key}) : super(key: key);

  @override
  State<SetDream> createState() => _SetDreamState();
}

class _SetDreamState extends State<SetDream> {
  bool isLoad = true;
  final formKey = GlobalKey<FormState>();
  DateTime dateNow = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    setState(() {
      isLoad = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Set Your Dream",
        isPop: true,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SpacerHeight(h: 20),
                    RegularForm(
                      title: "What are you dream of?",
                      hint: "eg: New Smartphone, Traveling",
                      controller: nameController,
                      isValidator: true,
                    ),
                    SpacerHeight(h: 20),
                    RegularForm(
                      title: "How much is it?",
                      hint: "eg: 100000",
                      controller: priceController,
                      isValidator: true,
                      keyboardType: TextInputType.number,
                    ),
                    SpacerHeight(h: 20),
                    DateTimePickerForm(
                      title: "When exactly do you want it?",
                      hint: "t",
                      date: dateNow,
                      callback: (x) {
                        setState(() => dateNow = x);
                      },
                    ),
                    SpacerHeight(h: 20),
                    MultiLineForm(
                      title: "Describe why do you want it so bad?",
                      hint: "eg: Remembering why you want it.",
                      controller: descriptionController,
                      isValidator: false,
                    ),
                    SpacerHeight(h: 20),
                    SizedBox(
                      width: double.infinity,
                      child: IconTextButton(
                        title: "Delete Your Dream",
                        iconTitle: "trash-can-solid.svg",
                        buttonColor: CustomColor.redColor,
                        func: () async {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        color: CustomColor.backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CustomButton(
          title: "Save Your Dream",
          func: () async {},
        ),
      ),
    );
  }
}
