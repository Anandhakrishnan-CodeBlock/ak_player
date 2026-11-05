import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../player_import.dart';

class AKVideoPlayerWidget extends StatefulWidget {
  final double height;
  final double width;
  final String debugLabelText;
  final String? thumbnailUrl;
  final String videoUrl;
  final bool? isAsset;
  final PlayMode? playMode;
  final LastWatchedState? lastWatchedState;
  final bool? looping;
  final Function? onVideoError;
  final Function? onImageError;
  final BorderRadiusGeometry? borderRadius;
  final MuteConfig? muteConfig;
  final DurationConfig? durationConfig;
  final SeekBarConfig? seekBarConfig;
  final VideoConfig? videoConfig;
  final LoadingIndicationConfig? loadingIndicationConfig;
  final ThumbnailConfig? thumbnailConfig;

  const AKVideoPlayerWidget({
    required Key key,
    required this.height,
    required this.width,
    required this.debugLabelText,
    this.thumbnailUrl,
    required this.videoUrl,
    this.isAsset,
    this.playMode,
    this.lastWatchedState,
    this.looping,
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
  State<StatefulWidget> createState() => _AKVideoPlayerWidgetState();
}

class _AKVideoPlayerWidgetState extends State<AKVideoPlayerWidget> {
  final _smartManager = AKManager();
  final PlayerVariant _variant = PlayerVariant.detail;
  final PlayMode _playMode = PlayMode.auto;
  bool _activationScheduled = false;

  late VideoInfo _smartVideoInfo;
  late Stream<PlayerEvent> _videoStream;
  late BorderRadiusGeometry _borderRadius;
  late LastWatchedState _lastWatchedState;
  late bool _isAsset;
  late bool _looping;

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
      playMode: _playMode,
      lastWatchedState: _lastWatchedState,
      isAsset: _isAsset,
      looping: _looping,
    );
    _smartManager.onInit(info: _smartVideoInfo, key: widget.key!);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AKVideoPlayerWidget oldWidget) {
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
    return VideoInfoWidget(
      key: _smartVideoInfo.key,
      onPaint: (activateOnPaint) {
        if (activateOnPaint &&
            _smartManager.selectedKey != widget.key &&
            !_activationScheduled) {
          _activationScheduled = true;
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _activationScheduled = false;
            _smartManager.startDrawing(key: widget.key!);
          });
        }
      },
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: StreamBuilder<PlayerEvent>(
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
                        );
                        break;
                      case PlayerEventStatus.failed:
                        content = const ErrorFace(text: 'Failed to load video');
                        break;
                      case PlayerEventStatus.ready:
                        content = VideoFace(
                          controller: event.controller!,
                          playMode: _playMode,
                          variant: _variant,
                          muteConfig: widget.muteConfig,
                          durationConfig: widget.durationConfig,
                          seekBarConfig: widget.seekBarConfig,
                          videoConfig: widget.videoConfig,
                          smartVideoInfo: _smartVideoInfo,
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
        ),
      ),
    );
  }
}
