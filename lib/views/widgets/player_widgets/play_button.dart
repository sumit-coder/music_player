import 'package:flutter/material.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({super.key, required this.isPlaying, required this.onTap, this.iconSize});
  final bool isPlaying;
  final VoidCallback onTap;
  final double? iconSize;

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
      iconSize: widget.iconSize,
      icon: Icon(
        widget.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
        // size: widget.iconSize,
      ),
    );
  }
}
