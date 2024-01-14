import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;

  const RoundedContainer({
    required this.child,
    this.height = 50,
    this.width = 100,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border:
              Border.all(style: BorderStyle.solid, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: child),
      ),
    );
  }
}
