import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/themes/app_colors.dart';
import 'package:movie_app/presentation/widgets/button.dart';

class AboutUsDialog extends StatelessWidget {
  final String title, description, buttontxt;
  final Widget? imagelogo;
  const AboutUsDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.buttontxt,
      this.imagelogo});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.vulcan,
      elevation: Sizes.dimen_32,
      child: Container(
        padding: EdgeInsets.only(
          top: Sizes.dimen_4.h,
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
        ),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.vulcan,
              blurRadius: Sizes.dimen_16,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Sizes.dimen_18.h,
            ),
            Text(
              title.t(context),
              style: TextStyle(fontSize: Sizes.dimen_24.sp),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
              child: Text(
                description.t(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: Sizes.dimen_32.h,
            ),
            if (imagelogo != null) imagelogo!,
            SizedBox(
              height: Sizes.dimen_32.h,
            ),
            Button(
              bttontxt: buttontxt,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: Sizes.dimen_32.h,
            )
          ],
        ),
      ),
    );
  }
}
