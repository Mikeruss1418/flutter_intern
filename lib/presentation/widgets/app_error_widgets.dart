import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/presentation/widgets/button.dart';
import 'package:wiredash/wiredash.dart';

import '../../common/constants/translation.dart';

class ApperrorWidgets extends StatelessWidget {
  final AppErrorType appErrorType;
  final Function() onPressed;
  const ApperrorWidgets(
      {super.key, required this.appErrorType, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          appErrorType == AppErrorType.apicall
              ? Translation.somethingWentWrong.t(context)
              : Translation.checkNetwork.t(context),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(
              bttontxt: Translation.retry,
              onTap: onPressed,
            ),
            SizedBox(
              width: Sizes.dimen_10.w,
            ),
            Button(
                bttontxt: Translation.feedback,
                onTap: () {
                  // bloc.add(const CarouselLoadEvent());
                  Wiredash.of(context).show();
                }),
          ],
        )
      ],
    );
  }
}
