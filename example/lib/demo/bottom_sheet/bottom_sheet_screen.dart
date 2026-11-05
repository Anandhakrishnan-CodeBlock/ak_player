import 'package:ak_player/ak_player/player_import.dart';
import 'package:flutter/material.dart';

import '../../assets/video_urls.dart';
import '../widgets/bottom_sheet_child_view.dart';
import '../widgets/bottom_sheet_parent_view.dart';

class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AKPlayer(
            key: ValueKey('bottom_sheet_1'),
            videoUrl: VideoUrls.landscapeVideo,
            debugLabelText: "bottom_sheet_1",
            width: double.infinity,
            //thumbnailUrl: ImageUrls.landscapeImages[9],
            playMode: PlayMode.auto,
            lastWatchedState: LastWatchedState.save,
            isAsset: false,
            looping: true,
            height: 250,
            loadingIndicationConfig: LoadingIndicationConfig(
              indicatorType: IndicatorType.circularIndicator,
              circularIndicatorColor: Colors.white,
              circularIndicatorBackgroundColor: Colors.black,
              circularIndicatorStrokeWidth: 5.0,
            ),
          ),
          BottomSheetParentView(),
          SizedBox(height: 35),
          ElevatedButton(
            onPressed: () {
              _showModalBottomSheet(context);
            },
            child: Text("Open Bottom Sheet"),
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min, // Wrap content height
            children: [
              AKPlayer(
                key: ValueKey('bottom_sheet_2'),
                videoUrl: VideoUrls.landscapeVideo,
                debugLabelText: "bottom_sheet_2",
                width: double.infinity,
                playMode: PlayMode.auto,
                lastWatchedState: LastWatchedState.save,
                isAsset: false,
                looping: true,
                height: 250,
              ),
              BottomSheetChildView(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
