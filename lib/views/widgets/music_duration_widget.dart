import 'package:flutter/material.dart';

class MusicDurationWidget extends StatefulWidget {
  const MusicDurationWidget({super.key, required this.songDurationInMilliseconds});

  final int songDurationInMilliseconds;

  @override
  State<MusicDurationWidget> createState() => _MusicDurationWidgetState();
}

class _MusicDurationWidgetState extends State<MusicDurationWidget> {
  @override
  Widget build(BuildContext context) {
    int hours = Duration(milliseconds: widget.songDurationInMilliseconds).inHours;
    int minutes = Duration(milliseconds: widget.songDurationInMilliseconds).inMinutes % 60;
    int seconds = Duration(milliseconds: widget.songDurationInMilliseconds).inSeconds % 60;

    String hourString = hours > 0 ? "$hours:" : "";
    String minuteString = minutes.toString().padLeft(2, '0');
    String secondString = seconds.toString().padLeft(2, '0');

    String songDuration = "$hourString$minuteString:$secondString";
    return Text(
      songDuration,
      style: const TextStyle(color: Colors.grey),
    );
  }
}
