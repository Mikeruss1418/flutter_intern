import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/presentation/themes/app_colors.dart';

import '../../common/constants/size_constants.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.h),
      child: Container(
        height: Sizes.dimen_1.h,
        width: Sizes.dimen_80.w,
        padding: EdgeInsets.only(
          top: Sizes.dimen_2.h,
          bottom: Sizes.dimen_6.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_1.h)),
          gradient: const LinearGradient(
            colors: [
              AppColors.violet,
              AppColors.royalblue,
            ],
          ),
        ),
      ),
    );
  }
}
