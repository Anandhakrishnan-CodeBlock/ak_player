import 'package:flutter/material.dart';

class BottomSheetParentView extends StatelessWidget {
  const BottomSheetParentView({super.key});

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
          SizedBox(height: 16),
          Text(
            'Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            'Designed to handle single-video playback for detail views.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          SizedBox(height: 12),
          Text(
            '• Seamlessly handles the navigation stack',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            '• Plays the primary view by default',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            '• Automatically manages playback on navigation changes, loading the video currently on top',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            '• To test, tap the "Open Bottom Sheet" button',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
        ],
      ),
    );
  }
}
