import 'package:flutter/material.dart';

import '../../player_import.dart';

abstract mixin class InfoControls {
  Key? get selectedKey;

  Map<Key, VideoInfo> get videos;

  set setVideos(Map<Key, VideoInfo> videos);

  void addInfo({required VideoInfo info, required Key key});

  void setInfo({
    required Key key,
    required OnLoading onLoading,
    required OnVideoReady onReady,
    required OnVideoError onError,
  });

  void clearInfo({required Key key});

  void clearAll();

  void saveLastWatchedVideo();

  void playLastWatchedVideo({required Function startDrawing});

  void pauseVideo();

  void stopVideo();
}
