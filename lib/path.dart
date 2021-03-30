import 'package:flutter/material.dart';

class MyPath extends StatelessWidget {
  final innerColor;
  final outerColor;
  final child;

  MyPath({this.innerColor, this.outerColor, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: EdgeInsets.all(12),
          color: outerColor,
          child: Center(child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: innerColor,
              child: Center(child: child),
            ),
          ),),
        ),
      ),
    );
  }
}
