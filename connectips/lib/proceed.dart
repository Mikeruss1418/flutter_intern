import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants.dart';

class SubmitBtn extends StatelessWidget {
  final String txt;
  final Function() onTap;
  const SubmitBtn({super.key, required this.txt, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        margin: EdgeInsets.only(
          bottom: 25.h,
        ),
        width: MediaQuery.of(context).size.width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: themecolor,
        ),
        child: Center(
            child: Text(
          txt,
          style: style.copyWith(fontSize: 20.sp, color: Colors.white),
        )),
      ),
    );
  }
}
