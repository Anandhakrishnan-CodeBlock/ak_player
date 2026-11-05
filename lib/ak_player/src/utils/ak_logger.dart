import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import '../../player_import.dart';

class AKLogger {
  AKLogger._();

  // ANSI Escape Codes
  static const String _reset = '\x1B[0m';
  static const String _green = '\x1B[32m'; // ADD
  static const String _yellow = '\x1B[33m'; // CLEAR
  static const String _red = '\x1B[31m'; // CLEAR ALL
  static const String _cyan = '\x1B[36m'; // SELECTED
  static const String _magenta = '\x1B[35m'; // PLAYING // INFO

  static const int _opWidth = 10;
  static const int _keyWidth = 15;
  static const int _urlWidth = 100;
  static const int _loopWidth = 7;

  static void added<T>(Key key, [Map<Key, T>? data]) {
    _log(operation: 'ADD', key: key, color: _green, data: data);
  }

  static void cleared<T>(Key key, [Map<Key, T>? data]) {
    _log(operation: 'CLEAR', key: key, color: _yellow, data: data);
  }

  static void clearAll<T>(Key? key, [Map<Key, T>? data]) {
    _log(operation: 'CLEAR_ALL', key: key, color: _red, data: data);
  }

  static void currentValue<T>(Key key, [Map<Key, T>? data]) {
    _log(operation: 'SELECTED', key: key, color: _cyan, data: data);
  }

  static void paint<T>(Key key, [Map<Key, T>? data]) {
    _log(operation: 'PLAYING', key: key, color: _magenta, data: data);
  }

  static void info(String tag, String data, bool looping, [Key? key]) {
    _renderTable(
      rows: [
        _TableRow(
          operation: tag.isEmpty ? 'INFO' : tag.toUpperCase(),
          key: _formatKey(key),
          videoUrl: data,
          looping: looping.toString(),
        ),
      ],
      color: _magenta,
    );
  }

  static void _log<T>({
    required String operation,
    required Key? key,
    required String color,
    Map<Key, T>? data,
  }) {
    if (!kDebugMode) return;

    final List<_TableRow> rows = [];

    if (data != null && data.isNotEmpty) {
      if (key != null) {
        final value = data[key];
        rows.add(_buildRow(operation, key, value));
      } else {
        // Clear all or batch: list all available entries
        for (final entry in data.entries) {
          rows.add(_buildRow(operation, entry.key, entry.value));
        }
      }
    } else if (data != null && data.isEmpty) {
      rows.add(
        _TableRow(
          operation: operation,
          key: _formatKey(key),
          videoUrl: 'Map is empty',
          looping: '-',
        ),
      );
    } else {
      rows.add(
        _TableRow(
          operation: operation,
          key: _formatKey(key),
          videoUrl: 'No data',
          looping: '-',
        ),
      );
    }

    _renderTable(rows: rows, color: color);
  }

  static String _formatKey(Key? key) {
    if (key == null) return '-';
    final str = key.toString();

    // Strips wrapper brackets: "[<'my_key'>]" -> "my_key"
    final match = RegExp(
      r"\[<['"
      "]?(.*?)['"
      "]?>]",
    ).firstMatch(str);
    if (match != null && match.group(1) != null) {
      return match.group(1)!;
    }

    // Handles standard ValueKey('...') or generic string representations
    return str.replaceAll("ValueKey<String>('", "").replaceAll("')", "");
  }

  static _TableRow _buildRow(String operation, Key? key, dynamic value) {
    final keyStr = _formatKey(key);

    if (value is VideoInfo) {
      return _TableRow(
        operation: operation,
        key: keyStr,
        videoUrl: value.videoUrl.toString(),
        looping: value.looping.toString(),
      );
    }

    return _TableRow(
      operation: operation,
      key: keyStr,
      videoUrl: value?.toString() ?? 'N/A',
      looping: '-',
    );
  }

  static List<String> _wrapText(String text, int width) {
    if (text.isEmpty) return [''];
    final List<String> chunks = [];
    for (int i = 0; i < text.length; i += width) {
      final end = math.min(i + width, text.length);
      chunks.add(text.substring(i, end));
    }
    return chunks;
  }

  static void _renderTable({
    required List<_TableRow> rows,
    required String color,
  }) {
    if (!kDebugMode || rows.isEmpty) return;

    final top =
        '$color┌${'─' * (_opWidth + 2)}┬${'─' * (_keyWidth + 2)}┬${'─' * (_urlWidth + 2)}┬${'─' * (_loopWidth + 2)}┐$_reset';
    final header =
        '$color│ ${'OPERATION'.padRight(_opWidth)} │ ${'KEY'.padRight(_keyWidth)} │ ${'VIDEO URL'.padRight(_urlWidth)} │ ${'LOOPING'.padRight(_loopWidth)} │$_reset';
    final divider =
        '$color├${'─' * (_opWidth + 2)}┼${'─' * (_keyWidth + 2)}┼${'─' * (_urlWidth + 2)}┼${'─' * (_loopWidth + 2)}┤$_reset';
    final bottom =
        '$color└${'─' * (_opWidth + 2)}┴${'─' * (_keyWidth + 2)}┴${'─' * (_urlWidth + 2)}┴${'─' * (_loopWidth + 2)}┘$_reset';

    final buffer = StringBuffer();
    buffer.writeln(top);
    buffer.writeln(header);
    buffer.writeln(divider);

    for (int r = 0; r < rows.length; r++) {
      final row = rows[r];
      final opLines = _wrapText(row.operation, _opWidth);
      final keyLines = _wrapText(row.key, _keyWidth);
      final urlLines = _wrapText(row.videoUrl, _urlWidth);
      final loopLines = _wrapText(row.looping, _loopWidth);

      final maxLines = math.max(
        math.max(opLines.length, keyLines.length),
        math.max(urlLines.length, loopLines.length),
      );

      for (int i = 0; i < maxLines; i++) {
        final op = i < opLines.length ? opLines[i] : '';
        final keyText = i < keyLines.length ? keyLines[i] : '';
        final url = i < urlLines.length ? urlLines[i] : '';
        final loop = i < loopLines.length ? loopLines[i] : '';

        buffer.writeln(
          '$color│ ${op.padRight(_opWidth)} │ ${keyText.padRight(_keyWidth)} │ ${url.padRight(_urlWidth)} │ ${loop.padRight(_loopWidth)} │$_reset',
        );
      }

      if (r < rows.length - 1) {
        buffer.writeln(divider);
      }
    }

    buffer.write(bottom);
    debugPrint(buffer.toString());
  }
}

class _TableRow {
  final String operation;
  final String key;
  final String videoUrl;
  final String looping;

  const _TableRow({
    required this.operation,
    required this.key,
    required this.videoUrl,
    required this.looping,
  });
}
