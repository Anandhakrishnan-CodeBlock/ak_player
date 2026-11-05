import 'package:ak_player/ak_player/player_import.dart';
import 'package:flutter/material.dart';

import '../../assets/image_urls.dart';
import '../../assets/video_urls.dart';
import 'grid_item_screen.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<StatefulWidget> createState() => GridScreenState();
}

class GridScreenState extends State<GridScreen> {
  final gridConfig = GridConfig(
    itemCount: ImageUrls.portraitListImages.length,
    crossAxisCount: 2,
    childAspectRatio: 9 / 16,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: gridConfig.padding,
        itemCount: gridConfig.itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridConfig.crossAxisCount,
          mainAxisSpacing: gridConfig.mainAxisSpacing,
          crossAxisSpacing: gridConfig.crossAxisSpacing,
          childAspectRatio: gridConfig.childAspectRatio,
          mainAxisExtent: gridConfig.mainAxisExtent,
        ),
        itemBuilder: (context, index) {
          final itemKey = ValueKey("grid_screen_$index");
          return AKGridItem(
            itemKey: itemKey,
            index: index,
            gridConfig: gridConfig,
            visibleThreshold: 0.9,
            stepExtent: 90,
            child: LayoutBuilder(
              builder: (context, boxConstraints) {
                return AKGridPlayer(
                  key: itemKey,
                  videoUrl: VideoUrls.portraitVideo,
                  thumbnailUrl: ImageUrls.portraitListImages[index],
                  debugLabelText: 'Video $index',
                  height: boxConstraints.maxHeight,
                  width: boxConstraints.maxWidth,
                  lastWatchedState: LastWatchedState.save,
                  looping: false,
                  onClickGridItem: () {
                    debugPrint('Tapped on Video $index');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GridItemScreen(
                          index: index,
                          videoUrl: VideoUrls.portraitVideo,
                          thumbnailUrls: ImageUrls.portraitListImages,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
