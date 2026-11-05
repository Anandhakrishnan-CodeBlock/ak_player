import 'package:flutter/material.dart';

import '../../../player_import.dart';

class LoadingThumbnailFace extends StatelessWidget {
  final double width;
  final double height;
  final String? thumbnailUrl;
  final Function? onImageError;
  final LoadingIndicationConfig? loadingIndicationConfig;
  final ThumbnailConfig? thumbnailConfig;
  final VoidCallback? onClickItem;

  const LoadingThumbnailFace({
    super.key,
    required this.width,
    required this.height,
    this.thumbnailUrl,
    this.onImageError,
    this.loadingIndicationConfig = const LoadingIndicationConfig(),
    this.thumbnailConfig,
    this.onClickItem,
  });

  @override
  Widget build(BuildContext context) {
    return (thumbnailUrl != null)
        ? InkWell(
            onTap: () {
              onClickItem?.call();
            },
            child: ThumbnailImage(
              width: width,
              height: height,
              thumbnailUrl: thumbnailUrl!,
              onImageError: onImageError,
              loadingIndicationConfig: loadingIndicationConfig,
              thumbnailConfig: thumbnailConfig,
            ),
          )
        : LoadingFace(
            width: width,
            height: height,
            loadingIndicationConfig: loadingIndicationConfig,
            child: Container(),
          );
  }
}
