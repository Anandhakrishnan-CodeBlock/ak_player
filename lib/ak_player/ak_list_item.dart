import 'package:flutter/widgets.dart';

import 'player_import.dart';

class AKListItem extends StatelessWidget {
  final Key itemKey;
  final Duration duration;
  final Widget child;
  final bool isFirst;
  final bool isLast;

  const AKListItem({
    super.key,
    required this.itemKey,
    required this.duration,
    required this.child,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return AKListItemWidget(
      itemKey: itemKey,
      duration: duration,
      isFirst: isFirst,
      isLast: isLast,
      child: child,
    );
  }
}
