import 'package:flutter/material.dart';

class ThumbnailConfig {
  final BoxFit fit;
  final ImageRepeat imageRepeat;
  final FilterQuality filterQuality;

  ThumbnailConfig({
    this.fit = BoxFit.cover,
    this.imageRepeat = ImageRepeat.noRepeat,
    this.filterQuality = FilterQuality.medium,
  });
}
