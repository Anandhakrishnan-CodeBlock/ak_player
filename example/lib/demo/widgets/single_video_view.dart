import 'package:flutter/material.dart';

import 'icons_view.dart';

class SingleVideoView extends StatelessWidget {
  const SingleVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          IconsView(),
          SizedBox(height: 8),
          Text(
            'Smart Player Widget',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
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
            '• Seamless transition when selecting an item from a list',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            '• Integrated action overlay (Like, Share, Save, and more)',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            '• Isolated video lifecycle management per view',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            '• Video player auto load corresponding video for view based on user interaction like',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text('  • Navigation', style: TextStyle(fontSize: 14, height: 1.4)),
          Text(
            '  • Tab View Change',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            '  • Bottom Navigation Change',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
        ],
      ),
    );
  }
}
