import 'package:flutter/foundation.dart';

import '../../player_import.dart';

class VideoInfo {
  final Key key;
  final String videoUrl;
  final String debugLabelText;
  final String? thumbnailUrl;
  final PlayMode playMode;
  final LastWatchedState lastWatchedState;
  final bool? isAsset;
  final bool looping;
  Duration savedPosition = Duration.zero;
  bool isLastWatched = false;

  VideoInfo({
    required this.key,
    required this.videoUrl,
    required this.debugLabelText,
    this.thumbnailUrl,
    this.playMode = PlayMode.auto,
    this.lastWatchedState = LastWatchedState.forgot,
    this.isAsset,
    this.looping = false,
    this.savedPosition = Duration.zero,
    this.isLastWatched = false,
  });
}
