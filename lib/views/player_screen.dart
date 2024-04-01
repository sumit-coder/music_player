import 'package:flutter/material.dart';
import 'package:music_player/views/widgets/player_widgets/play_button.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          // Playback Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.shuffle_rounded, size: 24)),
              IconButton(onPressed: () {}, icon: Icon(Icons.skip_previous_rounded, size: 34)),
              // IconButton(onPressed: () {}, icon: Icon(Icons.play_circle_fill_rounded, size: 44)),
              PlayButton(
                isPlaying: true,
                onChange: (bool newValue) {
                  print(newValue);
                },
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.skip_next_rounded, size: 34)),
              IconButton(onPressed: () {}, icon: Icon(Icons.repeat_rounded, size: 24)),
            ],
          )
        ],
      ),
    );
  }
}
