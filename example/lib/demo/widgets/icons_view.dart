import 'package:flutter/material.dart';

class IconsView extends StatelessWidget {
  const IconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up)),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.thumb_down_off_alt_rounded),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border_rounded)),
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
      ],
    );
  }
}
