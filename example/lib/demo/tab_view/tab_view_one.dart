import 'package:ak_player/ak_player/player_import.dart';
import 'package:flutter/material.dart';

import '../../assets/image_urls.dart';
import '../../assets/video_urls.dart';
import '../widgets/single_video_view.dart';

class TabViewOne extends StatelessWidget {
  const TabViewOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AKPlayer(
            key: ValueKey("tab_view_one"),
            videoUrl: VideoUrls.landscapeVideo,
            debugLabelText: "tab_view_one",
            width: double.infinity,
            thumbnailUrl: ImageUrls.landscapeImages[8],
            playMode: PlayMode.auto,
            lastWatchedState: LastWatchedState.save,
            looping: true,
            height: 250,
          ),
          SingleVideoView(),
        ],
      ),
    );
  }
}
