import 'package:flutter/material.dart';

class SpacerHeight extends StatelessWidget {
  const SpacerHeight({Key key, this.h}) : super(key: key);
  final double h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: h);
  }
}

class SpacerWidth extends StatelessWidget {
  const SpacerWidth({Key key, this.w}) : super(key: key);
  final double w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: w);
  }
}
