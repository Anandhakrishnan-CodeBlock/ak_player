import 'package:ak_player/ak_player/player_import.dart';
import 'package:flutter/material.dart';

import '../widgets/single_video_view.dart';


class ListItemScreen extends StatelessWidget {
  final int index;
  final String videoUrl;
  final String thumbnailUrl;

  const ListItemScreen({
    super.key,
    required this.index,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Item')),
      body: Builder(
        builder: (innerContext) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AKPlayer(
                key: ValueKey("list_item_$index"),
                videoUrl: videoUrl,
                thumbnailUrl: thumbnailUrl,
                debugLabelText: "list_item_$index",
                width: double.infinity,
                playMode: PlayMode.auto,
                lastWatchedState: LastWatchedState.save,
                looping: true,
                height: 250,
              ),
              SingleVideoView(),
            ],
          );
        },
      ),
    );
  }
}
