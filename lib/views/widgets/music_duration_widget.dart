import 'package:flutter/material.dart';

class MusicDurationWidget extends StatefulWidget {
  const MusicDurationWidget({super.key, required this.songDurationInMilliseconds});

  final int songDurationInMilliseconds;

  @override
  State<MusicDurationWidget> createState() => _MusicDurationWidgetState();
}

class _MusicDurationWidgetState extends State<MusicDurationWidget> {
  String songDuration = '';

  @override
  void initState() {
    // songDuration = Duration(milliseconds: widget.songDurationInMilliseconds).inMinutes.toString();

    int hours = Duration(milliseconds: widget.songDurationInMilliseconds).inHours;
    int minutes = Duration(milliseconds: widget.songDurationInMilliseconds).inMinutes % 60;
    int seconds = Duration(milliseconds: widget.songDurationInMilliseconds).inSeconds % 60;

    String hourString = hours > 0 ? "$hours:" : "";
    String minuteString = minutes.toString().padLeft(2, '0');
    String secondString = seconds.toString().padLeft(2, '0');

    songDuration = "$hourString$minuteString:$secondString";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(songDuration, style: TextStyle(color: Colors.grey));
  }
}
