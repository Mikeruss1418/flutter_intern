import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dialogtxt extends StatelessWidget {
  final String label;
  final String count;
  final Color color;
  const Dialogtxt({super.key, required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 15.sp, color: Colors.black),
        children: [
          TextSpan(text: label),
          TextSpan(
            text: count,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
