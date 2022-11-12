import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var box = Hive.box('auth');
  @override
  void initState() {
    super.initState();

    print(box.getAt(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SizedBox());
  }
}
