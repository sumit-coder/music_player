import 'package:flutter/material.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({super.key, required this.isPlaying, required this.onTap});
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.onTap();
      },
      icon: Icon(widget.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded, size: 44),
    );
  }
}
