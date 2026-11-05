import 'package:flutter/widgets.dart';

import 'player_import.dart';

class AKGridItem extends StatelessWidget {
  final Key itemKey;
  final int index;
  final GridConfig gridConfig;
  final Duration settleDuration;
  final double stepExtent;
  final double visibleThreshold;
  final Widget child;

  const AKGridItem({
    super.key,
    required this.itemKey,
    required this.index,
    required this.gridConfig,
    required this.child,
    required this.stepExtent,
    this.visibleThreshold = 0.5,
    this.settleDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    return AKGridItemWidget(
      itemKey: itemKey,
      index: index,
      gridConfig: gridConfig,
      visibleThreshold: visibleThreshold,
      stepExtent: stepExtent,
      settleDuration: settleDuration,
      child: child,
    );
  }
}
