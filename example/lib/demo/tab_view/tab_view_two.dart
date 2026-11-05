import 'package:ak_player/ak_player/player_import.dart';
import 'package:flutter/material.dart';

import '../../assets/image_urls.dart';
import '../../assets/video_urls.dart';
import '../list_view/list_item_screen.dart';
import '../widgets/list_video_view.dart';

class TabViewTwo extends StatelessWidget {
  const TabViewTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: ImageUrls.landscapeListImages.length,
        itemBuilder: (context, index) {
          final itemKey = ValueKey("tab_view_two_$index");
          return Column(
            children: [
              AKListItem(
                itemKey: itemKey,
                isFirst: index == 0,
                isLast: index == ImageUrls.landscapeListImages.length - 1,
                duration: const Duration(milliseconds: 200),
                child: AKListPlayer(
                  key: itemKey,
                  videoUrl: VideoUrls.landscapeVideo,
                  thumbnailUrl: ImageUrls.landscapeListImages[index],
                  debugLabelText: 'Video $index',
                  height: 240,
                  width: double.infinity,
                  lastWatchedState: LastWatchedState.save,
                  looping: false,
                  onClickListItem: () {
                    debugPrint('Tapped on Video $index');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ListItemScreen(
                          index: index,
                          videoUrl: VideoUrls.landscapeVideo,
                          thumbnailUrl: ImageUrls.landscapeListImages[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ListVideoView(index: index),
            ],
          );
        },
      ),
    );
  }
}
