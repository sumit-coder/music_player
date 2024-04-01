import 'package:flutter/material.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({super.key, required this.isPlaying, required this.onChange});
  final bool isPlaying;
  final Function(bool newValue) onChange;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool isPlaying = false;

  @override
  void initState() {
    isPlaying = widget.isPlaying;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        isPlaying = !isPlaying;
        widget.onChange(isPlaying);
        setState(() {});
      },
      icon: Icon(isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded, size: 44),
    );
  }
}
