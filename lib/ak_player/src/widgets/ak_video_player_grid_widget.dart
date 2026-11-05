import 'dart:async';
import 'package:flutter/material.dart';

import '../../player_import.dart';

class AKVideoPlayerGridWidget extends StatefulWidget {
  final double height;
  final double width;
  final String debugLabelText;
  final String thumbnailUrl;
  final String videoUrl;
  final bool? isAsset;
  final LastWatchedState? lastWatchedState;
  final bool? looping;
  final VoidCallback onClickGridItem;
  final Function? onVideoError;
  final Function? onImageError;
  final BorderRadiusGeometry? borderRadius;
  final MuteConfig? muteConfig;
  final DurationConfig? durationConfig;
  final SeekBarConfig? seekBarConfig;
  final VideoConfig? videoConfig;
  final LoadingIndicationConfig? loadingIndicationConfig;
  final ThumbnailConfig? thumbnailConfig;

  const AKVideoPlayerGridWidget({
    required Key key,
    required this.height,
    required this.width,
    required this.debugLabelText,
    required this.thumbnailUrl,
    required this.videoUrl,
    this.isAsset,
    this.lastWatchedState,
    this.looping,
    required this.onClickGridItem,
    this.onVideoError,
    this.onImageError,
    this.borderRadius,
    this.muteConfig,
    this.durationConfig,
    this.seekBarConfig,
    this.videoConfig,
    this.loadingIndicationConfig,
    this.thumbnailConfig,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AKVideoPlayerGridWidgetState();
}

class _AKVideoPlayerGridWidgetState
    extends State<AKVideoPlayerGridWidget> {
  final _smartManager = AKManager();
  final PlayerVariant variant = PlayerVariant.grid;
  final PlayMode playMode = PlayMode.auto;

  late VideoInfo _smartVideoInfo;
  late Stream<PlayerEvent> _videoStream;
  late BorderRadiusGeometry _borderRadius =
      widget.borderRadius ?? BorderRadiusGeometry.zero;
  late LastWatchedState _lastWatchedState =
      widget.lastWatchedState ?? LastWatchedState.forgot;
  late bool _isAsset = widget.isAsset ?? false;
  late bool _looping = widget.looping ?? false;

  @override
  void initState() {
    _videoStream = _smartManager.selectedVideo;
    _borderRadius = widget.borderRadius ?? BorderRadiusGeometry.zero;
    _lastWatchedState = widget.lastWatchedState ?? LastWatchedState.forgot;
    _isAsset = widget.isAsset ?? false;
    _looping = widget.looping ?? false;

    _smartVideoInfo = VideoInfo(
      key: widget.key!,
      videoUrl: widget.videoUrl,
      debugLabelText: widget.debugLabelText,
      thumbnailUrl: widget.thumbnailUrl,
      playMode: playMode,
      lastWatchedState: _lastWatchedState,
      isAsset: _isAsset,
      looping: _looping,
    );
    _smartManager.onInit(info: _smartVideoInfo, key: widget.key!);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AKVideoPlayerGridWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.borderRadius != oldWidget.borderRadius) {
      _borderRadius = widget.borderRadius ?? BorderRadiusGeometry.zero;
    }
    if (widget.lastWatchedState != oldWidget.lastWatchedState) {
      _lastWatchedState = widget.lastWatchedState ?? LastWatchedState.forgot;
    }
    if (widget.isAsset != oldWidget.isAsset) {
      _isAsset = widget.isAsset ?? false;
    }
    if (widget.looping != oldWidget.looping) {
      _looping = widget.looping ?? false;
    }
  }

  @override
  void dispose() {
    _smartManager.onDispose(key: widget.key!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            StreamBuilder<PlayerEvent>(
              stream: _videoStream,
              initialData: null,
              builder:
                  (BuildContext context, AsyncSnapshot<PlayerEvent> snapshot) {
                    final event = snapshot.data;
                    final bool isMine = event?.key == widget.key;
                    Widget content;
                    if (!isMine) {
                      content = LoadingThumbnailFace(
                        width: widget.width,
                        height: widget.height,
                        thumbnailUrl: widget.thumbnailUrl,
                        onImageError: widget.onImageError,
                        loadingIndicationConfig: widget.loadingIndicationConfig,
                        thumbnailConfig: widget.thumbnailConfig,
                        onClickItem: widget.onClickGridItem,
                      );
                    } else {
                      switch (event!.status) {
                        case PlayerEventStatus.loading:
                          content = LoadingThumbnailFace(
                            width: widget.width,
                            height: widget.height,
                            thumbnailUrl: widget.thumbnailUrl,
                            onImageError: widget.onImageError,
                            loadingIndicationConfig:
                                widget.loadingIndicationConfig,
                            thumbnailConfig: widget.thumbnailConfig,
                            onClickItem: widget.onClickGridItem,
                          );
                          break;
                        case PlayerEventStatus.failed:
                          content = const ErrorFace(
                            text: 'Failed to load video',
                          );
                          widget.onVideoError?.call(event.error);
                          break;
                        case PlayerEventStatus.ready:
                          content = VideoFace(
                            controller: event.controller!,
                            playMode: playMode,
                            variant: variant,
                            muteConfig: widget.muteConfig,
                            durationConfig: widget.durationConfig,
                            seekBarConfig: widget.seekBarConfig,
                            videoConfig: widget.videoConfig,
                            smartVideoInfo: _smartVideoInfo,
                            onClickItem: widget.onClickGridItem,
                          );
                          break;
                      }
                    }

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: content,
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }
}
