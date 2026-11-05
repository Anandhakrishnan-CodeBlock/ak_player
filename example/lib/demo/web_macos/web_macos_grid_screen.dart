import 'package:ak_player/ak_player/player_import.dart';
import 'package:flutter/material.dart';

import '../../assets/image_urls.dart';
import '../../assets/video_urls.dart';

class WebMacosGridScreen extends StatefulWidget {
  const WebMacosGridScreen({super.key});

  @override
  State<StatefulWidget> createState() => WebMacosGridState();
}

class WebMacosGridState extends State<WebMacosGridScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: ImageUrls.portraitListImages.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 16 / 9,
        ),
        itemBuilder: (context, index) {
          final itemKey = ValueKey("grid_screen_web_mac_$index");
          return LayoutBuilder(
            builder: (context, boxConstraints) {
              return AKWebMacosGridPlayer(
                key: itemKey,
                videoUrl: VideoUrls.landscapeVideo,
                thumbnailUrl: ImageUrls.landscapeListImages[index],
                debugLabelText: 'Video $index',
                height: boxConstraints.maxHeight,
                width: boxConstraints.maxWidth,
                onClickGridItem: () {
                  debugPrint('Tapped on Video $index');
                },
                onVideoError: (error) {
                  debugPrint('Error: $error');
                },
              );
            },
          );
        },
      ),
    );
  }
}
