import 'package:flutter/material.dart';

class GradientRaisedButton extends StatelessWidget {
  GradientRaisedButton({
    this.height = 50,
    this.child,
    this.onPressed,
  });
  final double height;
  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: height,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(219, 165, 20, 1),
              Color.fromRGBO(183, 134, 40, 1),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
