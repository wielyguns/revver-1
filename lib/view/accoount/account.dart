import 'package:flutter/material.dart';
import 'package:revver/globals.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Account", style: CustomFont.heading24),
            ),
          ],
        ),
      ),
    );
  }
}
