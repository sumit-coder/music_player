import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/views/widgets/player_widgets/play_button.dart';
import 'package:music_player/views/widgets/player_widgets/repeat_button.dart';
import 'package:music_player/views/widgets/player_widgets/shuffle_button.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatefulWidget {
  final SongModel songInfo;

  const PlayerScreen({super.key, required this.songInfo});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    player.setFilePath(widget.songInfo.data);

    super.initState();
  }

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
                  const SizedBox(height: 18),
                  // Music Cover Album
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: QueryArtworkWidget(
                      // controller: _audioQuery,
                      artworkHeight: 300,
                      artworkWidth: size.width * 0.80,
                      id: widget.songInfo.id,
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
                      Text(widget.songInfo.title, style: const TextStyle(fontSize: 18, color: Colors.grey)),
                      Text(widget.songInfo.artist.toString(), style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  // Playback Timeline
                ],
              ),
              Column(
                children: [
                  // Playback Timeline
                  Column(
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
                  // Playback Controls
                  StreamBuilder<PlayerState>(
                    stream: player.playerStateStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ShuffleButton(
                              isShuffleOn: false,
                              onChange: (newValue) {},
                            ),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.skip_previous_rounded, size: 34)),
                            PlayButton(
                              isPlaying: snapshot.data!.playing,
                              onTap: () {
                                if (snapshot.data!.playing) {
                                  player.pause();
                                  return;
                                }
                                player.play();
                              },
                            ),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next_rounded, size: 34)),
                            RepeatButton(
                              isRepeatOn: false,
                              onChange: (newValue) {},
                            ),
                          ],
                        );
                      }

                      return const Text("Error");
                    },
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
