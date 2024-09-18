import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Question extends StatelessWidget {
  const Question({
    super.key,
    required this.body,
  });
  final dynamic body;
  @override
  Widget build(BuildContext context) {
    return Html(
      data: body,
      style: {
        'body': Style(fontSize: FontSize(16.sp), fontWeight: FontWeight.bold)
      },
    );
  }
}