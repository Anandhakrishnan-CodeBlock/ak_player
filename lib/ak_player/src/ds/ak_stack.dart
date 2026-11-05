import 'package:flutter/material.dart';
import '../../player_import.dart';

class AKStack {
  AKStack._internal();
  static final AKStack _instance = AKStack._internal();
  factory AKStack() {
    return _instance;
  }

  final List<Map<Key, VideoInfo>> _list = [];

  void push(Map<Key, VideoInfo> value) {
    _list.add(Map<Key, VideoInfo>.from(value));
    debugPrint('Push: $_list');
  }

  Map<Key, VideoInfo> pop() {
    if (_list.isEmpty) return {};
    final removed = _list.removeLast();
    debugPrint('Pop: $removed');
    return removed;
  }

  Map<Key, VideoInfo> top() {
    if (_list.isEmpty) {
      return {};
    }
    debugPrint('Top: ${_list.last}');
    return _list.last;
  }

  bool get isEmpty => _list.isEmpty;

  bool get isNotEmpty => _list.isNotEmpty;

  int get length => _list.length;

  @override
  String toString() => _list.toString();
}
