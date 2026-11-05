import 'package:flutter/material.dart';

import '../../../player_import.dart';

final class ThumbnailImage extends StatelessWidget {
  final double width;
  final double height;
  final String thumbnailUrl;
  final Function? onImageError;
  final LoadingIndicationConfig? loadingIndicationConfig;
  final ThumbnailConfig? thumbnailConfig;

  const ThumbnailImage({
    super.key,
    required this.width,
    required this.height,
    required this.thumbnailUrl,
    this.onImageError,
    this.loadingIndicationConfig,
    this.thumbnailConfig,
  });

  @override
  Widget build(BuildContext context) {
    final config = thumbnailConfig ?? ThumbnailConfig();
    return Image.network(
      key: key,
      thumbnailUrl,
      fit: config.fit,
      repeat: config.imageRepeat,
      filterQuality: config.filterQuality,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return LoadingFace(
          key: key,
          width: width,
          height: height,
          loadingIndicationConfig: loadingIndicationConfig,
          child: Container(),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        onImageError?.call(error);
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Thumbnail failed to load',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
