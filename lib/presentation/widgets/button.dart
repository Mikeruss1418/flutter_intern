import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/themes/app_colors.dart';

class Button extends StatelessWidget {
  final String bttontxt;
  final Function() onTap;
  const Button({super.key, required this.bttontxt, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: Sizes.dimen_100.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                // colors: [AppColors.royalblue, AppColors.violet]),
                colors: [AppColors.vulcan, AppColors.royalblue]),
            borderRadius: BorderRadius.circular(Sizes.dimen_20.w)),
        child: Center(child: Text(bttontxt)),
      ),
    );
  }
}
