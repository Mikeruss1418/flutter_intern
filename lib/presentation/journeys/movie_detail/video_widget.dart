import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/blocs/video/video_bloc.dart';
import 'package:movie_app/presentation/journeys/watch_trailer/watch_trailer_args.dart';
import 'package:movie_app/presentation/journeys/watch_trailer/watch_trailer_screen.dart';
import 'package:movie_app/presentation/widgets/button.dart';

import '../../../common/constants/size_constants.dart';
import '../../../common/constants/translation.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key, required this.videoBloc});
  final VideoBloc videoBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      bloc: videoBloc,
      builder: (context, state) {
        if (state.status == VideoStatus.success &&
            state.videos!.iterator.moveNext()) {
          final video = state.videos;
          return Padding(
            padding: EdgeInsets.only(
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_18.w,
                right: Sizes.dimen_18.w),
            child: Button(
                bttontxt: Translation.watchTrailers.t(context),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WatchTrailerScreen(
                            watchTrailerArguments:
                                WatchTrailerArguments(video!)),
                      ));
                }),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
