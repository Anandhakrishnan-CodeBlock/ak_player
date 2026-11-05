import 'package:flutter/material.dart';

class BottomSheetChildView extends StatelessWidget {
  const BottomSheetChildView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Smart Player Widget',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            '• The primary video loads automatically',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            '• The underlying stack video stops automatically',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            '• Popping the top view automatically reloads the previous video',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            '• To test, tap the "Close" button',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
        ],
      ),
    );
  }
}
