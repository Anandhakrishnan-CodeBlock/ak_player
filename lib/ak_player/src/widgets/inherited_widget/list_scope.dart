import 'package:flutter/widgets.dart';

/// Identify the nearest parent type AKListItemWidget

class ListScope extends InheritedWidget {
  const ListScope({super.key, required super.child});

  static bool isInsideList(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<ListScope>() != null;
  }

  @override
  bool updateShouldNotify(ListScope oldWidget) => false;
}
