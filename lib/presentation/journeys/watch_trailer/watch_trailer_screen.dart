import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/translation.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/domain/entities/video_entity.dart';
import 'package:movie_app/presentation/journeys/watch_trailer/watch_trailer_args.dart';
import 'package:movie_app/presentation/widgets/separator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../themes/app_colors.dart';

class WatchTrailerScreen extends StatefulWidget {
  const WatchTrailerScreen({super.key, required this.watchTrailerArguments});
  final WatchTrailerArguments watchTrailerArguments;

  @override
  State<WatchTrailerScreen> createState() => _WatchTrailerScreenState();
}

class _WatchTrailerScreenState extends State<WatchTrailerScreen> {
  late List<VideoEntity> videos;
  late YoutubePlayerController controller;
  // bool ismute = true;
  final ismute = ValueNotifier<bool>(true);
  @override
  void initState() {
    super.initState();
    videos = widget.watchTrailerArguments.videos;
    controller = YoutubePlayerController(
      initialVideoId: videos[0].key,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: ismute.value,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translation.watchTrailers.t(context),
          style: const TextStyle(color: AppColors.royalblue),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            onReady: () {
              controller.addListener(
                () {
                  if (ismute.value) {
                    controller.mute();
                  }
                },
              );
            },
            topActions: [
              ValueListenableBuilder(
                  valueListenable: ismute,
                  builder: (context, value, child) {
                    return IconButton(
                      onPressed: () {
                        if (ismute.value) {
                          controller.unMute();
                        } else {
                          controller.mute();
                        }
                        ismute.value = !ismute.value;
                      },
                      icon: Icon(
                          color: Colors.white,
                          ismute.value ? Icons.volume_off : Icons.volume_up),
                    );
                  })
            ],
            controller: controller,
            aspectRatio: 16 / 9,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
          ),
          builder: (context, player) {
            return Column(
              children: [
                player,
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Translation.morevideos.t(context),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Separator();
                    },
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.load(videos[index].key);
                              controller.play();
                            },
                            child: SizedBox(
                              height: 150.h,
                              width: 180.w,
                              child: CachedNetworkImage(
                                  imageUrl: YoutubePlayer.getThumbnail(
                                      videoId: videos[index].key)),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: Text(
                              videos[index].title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
