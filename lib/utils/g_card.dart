import 'package:flutter/material.dart';

class GCard extends StatelessWidget {
  const GCard({
    Key? key,
    required this.child,
   required this.width,
   required this.color,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.radius = 5,
  }) : super(key: key);
  final Widget child;
  final double width;
  final double radius;
  final Color color;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
