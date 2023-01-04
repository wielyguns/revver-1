import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({Key key}) : super(key: key);
  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Company Profile",
        isPop: true,
      ),
    );
  }
}
