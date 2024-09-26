import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/themes/app_colors.dart';

import '../../../data/core/api_constants.dart';
import '../../blocs/cast/cast_bloc.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(
      builder: (context, state) {
        if (state.status == CastStatus.success) {
          return SizedBox(
            height: 350.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.casts!.length,
              itemBuilder: (context, index) {
                final castEntity = state.casts?[index];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0.r),
                      child: Card(
                        shadowColor: AppColors.vulcan,
                        elevation: 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Text(
                              'Wait',
                              style: TextStyle(fontSize: 90.sp),
                            ),
                            height: Sizes.dimen_230.h,
                            width: Sizes.dimen_160.w,
                            imageUrl: (castEntity?.posterpath.isNotEmpty ??
                                    false)
                                ? '${ApiConstants.BASE_IMAGE_URL}${castEntity?.posterpath}'
                                : 'https://surgassociates.com/wp-content/uploads/610-6104451_image-placeholder-png-user-profile-placeholder-image-png-1.jpg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      castEntity!.name.about20(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Text(
                      'AS',
                      style: TextStyle(color: AppColors.violet),
                    ),
                    Text(
                      castEntity.character.about20(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
