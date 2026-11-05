import 'package:ak_player/ak_player/player_import.dart';
import 'package:flutter/material.dart';

import 'assets/image_urls.dart';
import 'assets/video_urls.dart';
import 'demo/app_navigation_drawer.dart';
import 'demo/widgets/single_video_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [NavigationController()],
      home: Scaffold(
        appBar: AppBar(title: const Text('Smart Video Player')),
        body: Builder(
          builder: (innerContext) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AKPlayer(
                  key: ValueKey("main_screen"),
                  videoUrl: VideoUrls.landscapeVideo,
                  debugLabelText: "main_screen",
                  width: double.infinity,
                  thumbnailUrl: ImageUrls.landscapeImages[8],
                  playMode: PlayMode.auto,
                  lastWatchedState: LastWatchedState.save,
                  looping: true,
                  height: 250,
                ),
                SingleVideoView(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(innerContext).push(
                    MaterialPageRoute(
                      builder: (context) => AppNavigationDrawer(),
                    ),
                  ),
                  child: const Text('DEMO'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
