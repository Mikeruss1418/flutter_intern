// import 'package:flutter/material.dart';
// import 'package:movieapp/common/constants/size_constants.dart';
// import 'package:movieapp/common/extensions/string_extensions.dart';
// import 'package:movieapp/common/extensions/size_extensions.dart';
// import 'package:movieapp/presentation/themes/theme_color.dart';

// class Button extends StatelessWidget {
//   final String text;
//   final Function onPressed;

//   const Button({
//     Key key,
//     @required this.text,
//     @required this.onPressed,
//   })

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColor.royalBlue,
//             AppColor.violet,
//           ],
//         ),
//         borderRadius: BorderRadius.all(
//           Radius.circular(Sizes.dimen_20.w),
//         ),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
//       margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
//       height: Sizes.dimen_16.h,
//       child: FlatButton(
//         onPressed: onPressed,
//         child: Text(
//           text.t(context),
//           style: Theme.of(context).textTheme.button,
//         ),
//       ),
//     );
//   }
// }
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
                colors: [AppColors.royalblue, AppColors.violet]),
            borderRadius: BorderRadius.circular(Sizes.dimen_20.w)),
        child: Center(child: Text(bttontxt)),
      ),
    );
  }
}
