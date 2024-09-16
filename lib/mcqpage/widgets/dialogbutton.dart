import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BuildDialogbtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  const BuildDialogbtn({super.key, required this.text, required this.onPressed, required this.isPrimary});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 45.h,
        width: 120.w,
        decoration: BoxDecoration(
          color: isPrimary ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: isPrimary ?null: Border.all(color: Colors.grey)
        ),
        child: Center(
          child: Text(text,style: TextStyle(
            color: isPrimary ? Colors.white : Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}
