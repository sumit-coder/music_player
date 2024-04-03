import 'package:flutter/material.dart';
import 'package:music_player/views/widgets/player_widgets/play_button.dart';
import 'package:music_player/views/widgets/player_widgets/repeat_button.dart';
import 'package:music_player/views/widgets/player_widgets/shuffle_button.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Music Cover Album
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "https://i.ytimg.com/vi/725WlG1idPc/maxresdefault.jpg",
              width: size.width * 0.80,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          // Playback Timeline
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    thumbColor: Colors.grey,
                    activeTrackColor: Colors.grey.shade600,
                    inactiveTrackColor: Colors.grey.shade800,
                    trackHeight: 2,
                  ),
                  child: Slider(
                    value: 0.6,
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('5:00', style: TextStyle(color: Colors.grey)),
                      Text('0:00', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Playback Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShuffleButton(
                isShuffleOn: false,
                onChange: (newValue) {},
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.skip_previous_rounded, size: 34)),
              PlayButton(
                isPlaying: true,
                onChange: (bool newValue) {
                  print(newValue);
                },
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next_rounded, size: 34)),
              RepeatButton(
                isRepeatOn: false,
                onChange: (newValue) {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
