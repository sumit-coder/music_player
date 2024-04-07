import 'package:flutter/material.dart';
import 'package:music_player/views/widgets/player_widgets/play_button.dart';
import 'package:music_player/views/widgets/player_widgets/repeat_button.dart';
import 'package:music_player/views/widgets/player_widgets/shuffle_button.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final SongModel songInfo;

  const PlayerScreen({super.key, required this.songInfo});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 18),
                  // Music Cover Album
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: QueryArtworkWidget(
                      // controller: _audioQuery,
                      artworkHeight: 300,
                      artworkWidth: size.width * 0.80,
                      id: songInfo.id,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.circular(12),
                      quality: 100,
                      artworkQuality: FilterQuality.high,
                      artworkFit: BoxFit.contain,
                    ),
                  ),
                  // Track Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(songInfo.title, style: TextStyle(fontSize: 18, color: Colors.grey)),
                      Text(songInfo.artist.toString(), style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  // Playback Timeline
                ],
              ),
              Column(
                children: [
                  Container(
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
                          padding: EdgeInsets.symmetric(horizontal: 6),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  ),
                  SizedBox(height: 50)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
