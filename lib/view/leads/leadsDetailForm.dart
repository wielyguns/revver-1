import 'package:flutter/material.dart';

class LeadsDetailForm extends StatefulWidget {
  const LeadsDetailForm({Key key}) : super(key: key);

  @override
  State<LeadsDetailForm> createState() => _LeadsDetailFormState();
}

class _LeadsDetailFormState extends State<LeadsDetailForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Detail"),
      ),
    );
  }
}
