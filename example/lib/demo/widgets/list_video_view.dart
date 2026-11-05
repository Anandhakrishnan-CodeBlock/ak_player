import 'package:flutter/material.dart';

class ListVideoView extends StatelessWidget {
  final int index;
  const ListVideoView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.list_rounded, color: Colors.white),
      ),
      title: Text('Video ${index + 1}'),
      subtitle: const Text('Smart List Player • Play video while scrolling'),
    );
  }
}
