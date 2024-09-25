import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';

class MovieDetailAppBar extends StatelessWidget {
  const MovieDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: Sizes.dimen_24.h,
          ),
        ),
        Icon(
          Icons.favorite_border_outlined,
          color: Colors.white,
          size: Sizes.dimen_24.h,
        ),
      ],
    );
  }
}
