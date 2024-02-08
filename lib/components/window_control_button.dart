import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.width,
    required this.height,
    required this.margin,
    required this.onPressed,
    required this.child,
  });

  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: InkWell(
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
