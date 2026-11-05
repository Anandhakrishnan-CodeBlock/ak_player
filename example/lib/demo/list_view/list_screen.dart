import 'package:ak_player/ak_player/player_import.dart';
import 'package:flutter/material.dart';

import '../../assets/image_urls.dart';
import '../../assets/video_urls.dart';
import '../widgets/list_video_view.dart';
import 'list_item_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: ImageUrls.landscapeListImages.length,
        itemBuilder: (context, index) {
          final itemKey = ValueKey("list_screen_$index");
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
