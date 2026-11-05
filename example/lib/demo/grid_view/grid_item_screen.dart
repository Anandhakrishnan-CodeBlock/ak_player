import 'package:ak_player/ak_player/player_import.dart';
import 'package:flutter/material.dart';

class GridItemScreen extends StatefulWidget {
  final int index;
  final String videoUrl;
  final List<String> thumbnailUrls;

  const GridItemScreen({
    super.key,
    required this.index,
    required this.videoUrl,
    required this.thumbnailUrls,
  });

  @override
  State<StatefulWidget> createState() => GridItemState();
}

class GridItemState extends State<GridItemScreen> {
  late ScrollController _scrollController;
  bool _isControllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isControllerInitialized) {
      final screenHeight = MediaQuery.sizeOf(context).height;
      _scrollController = ScrollController(
        initialScrollOffset: widget.index * screenHeight,
      );
      _isControllerInitialized = true;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero, // Crucial: removes default status bar / navigation padding
            physics: const PageScrollPhysics(),
            itemExtent: screenHeight,
            itemCount: widget.thumbnailUrls.length,
            itemBuilder: (context, index) {
              final itemKey = ValueKey("grid_item_$index");
              return SizedBox(
                height: screenHeight,
                width: constraints.maxWidth,
                child: AKListItem(
                  itemKey: itemKey,
                  isFirst: index == 0,
                  isLast: index == widget.thumbnailUrls.length - 1,
                  duration: const Duration(milliseconds: 200),
                  child: AKListPlayer(
                    key: itemKey,
                    videoUrl: widget.videoUrl,
                    thumbnailUrl: widget.thumbnailUrls[index],
                    thumbnailConfig: ThumbnailConfig(fit: BoxFit.contain),
                    debugLabelText: 'Video $index',
                    height: screenHeight,
                    width: constraints.maxWidth,
                    lastWatchedState: LastWatchedState.save,
                    looping: true,
                    onClickListItem: () {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
