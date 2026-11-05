import 'dart:async';

import 'package:flutter/widgets.dart';
import '../../player_import.dart';

class AKGridItemWidget extends StatefulWidget {
  final Key itemKey;
  final int index;
  final GridConfig gridConfig;
  final Duration settleDuration;
  final double stepExtent;
  final double visibleThreshold;
  final Widget child;

  const AKGridItemWidget({
    required this.itemKey,
    required this.index,
    required this.gridConfig,
    required this.child,
    required this.stepExtent,
    this.visibleThreshold = 0.5,
    this.settleDuration = const Duration(milliseconds: 200),
  }) : assert(
         settleDuration >= const Duration(milliseconds: 200),
         'SmartGridItemWidget.settleDuration must be at least 200ms. Shorter '
         'buffers make fast or boundary-jitter scrolling re-initialize the '
         'video player repeatedly, which is expensive and visibly janky.',
       ),
       assert(visibleThreshold > 0 && visibleThreshold <= 1),
       assert(stepExtent > 0),
       super(key: itemKey);

  @override
  State<AKGridItemWidget> createState() => _AKGridItemWidgetState();
}

class _AKGridItemWidgetState extends State<AKGridItemWidget> {
  static const double _edgeTolerance = 0.5;

  final _smartManager = AKManager();

  ZoneRenderBox? _renderBox;
  ScrollPosition? _scrollPosition;
  Timer? _settleTimer;
  bool _isCandidate = false;
  double _itemHeight = 0;
  double _rowExtent = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newPosition = Scrollable.maybeOf(context)?.position;
    if (_scrollPosition != newPosition) {
      _scrollPosition?.removeListener(_onScroll);
      _scrollPosition = newPosition;
      _scrollPosition?.addListener(_onScroll);
    }
  }

  @override
  void didUpdateWidget(covariant AKGridItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index ||
        oldWidget.gridConfig != widget.gridConfig ||
        oldWidget.visibleThreshold != widget.visibleThreshold ||
        oldWidget.settleDuration != widget.settleDuration ||
        oldWidget.stepExtent != widget.stepExtent) {
      _scheduleRecompute();
    }
  }

  void _scheduleRecompute() {
    final box = _renderBox;

    if (box == null || !mounted) return;

    final isMe =
        box.computeActiveIndex(
          itemHeight: _itemHeight,
          rowExtent: _rowExtent,
          visibleThreshold: widget.visibleThreshold,
          edgeTolerance: _edgeTolerance,
          stepExtent: widget.stepExtent,
          scrollPosition: _scrollPosition,
          gridConfig: widget.gridConfig,
        ) ==
        widget.index;
    if (isMe == _isCandidate) return;

    _isCandidate = isMe;
    _settleTimer?.cancel();
    if (!isMe) return;
    if (_smartManager.selectedKey == null) {
      _activate();
    } else {
      _settleTimer = Timer(widget.settleDuration, _activate);
    }
  }

  void _activate() {
    if (!mounted || !_isCandidate) return;
    if (_smartManager.selectedKey == widget.itemKey) return; // already playing
    _smartManager.startDrawing(key: widget.itemKey);
  }

  void _onScroll() => _scheduleRecompute();

  @override
  void dispose() {
    _settleTimer?.cancel();
    _scrollPosition?.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZoneRenderObjectWidget(
      itemKey: widget.itemKey,
      onRenderObjectCreated: (box) {
        _renderBox = box;
      },
      onPainted: _scheduleRecompute,
      child: LayoutBuilder(
        builder: (context, constraints) {
          _itemHeight = constraints.maxHeight;
          _rowExtent = _itemHeight + widget.gridConfig.mainAxisSpacing;
          return widget.child;
        },
      ),
    );
  }
}
