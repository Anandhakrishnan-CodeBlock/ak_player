import 'package:flutter/widgets.dart';

import '../../player_import.dart';

class ZoneRenderObjectWidget extends SingleChildRenderObjectWidget {
  final Key itemKey;
  final ValueChanged<ZoneRenderBox> onRenderObjectCreated;
  final VoidCallback onPainted;

  const ZoneRenderObjectWidget({
    super.key,
    required this.itemKey,
    required this.onRenderObjectCreated,
    required this.onPainted,
    required Widget child,
  }) : super(child: child);

  @override
  ZoneRenderBox createRenderObject(BuildContext context) {
    final box = ZoneRenderBox(itemKey: itemKey, onPainted: onPainted);
    onRenderObjectCreated(box);
    return box;
  }

  @override
  void updateRenderObject(BuildContext context, ZoneRenderBox renderObject) {
    renderObject
      ..itemKey = itemKey
      ..onPainted = onPainted;
  }
}
