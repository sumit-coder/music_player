import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:music_player/model/audio_file_model.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/providers/player_provider.dart';
import 'package:music_player/views/widgets/music_duration_widget.dart';
import 'package:music_player/views/widgets/player_widgets/play_button.dart';
import 'package:music_player/views/widgets/player_widgets/repeat_button.dart';
import 'package:music_player/views/widgets/player_widgets/shuffle_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key, required this.songInfo, required this.selectedIndex, required this.onTapDropDown});

  final AudioFile songInfo;
  final int selectedIndex;
  final VoidCallback onTapDropDown;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    var playerProvider = Provider.of<PlayerProvider>(context);
    var size = MediaQuery.of(context).size;
    AudioFile activeAudioFile = playerProvider.listAudioFiles[playerProvider.activeTrackIndex];
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            widget.onTapDropDown();
          },
          icon: Icon(Icons.keyboard_arrow_down_rounded, size: 38, color: Colors.grey.shade800),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var spf = await SharedPreferences.getInstance();
              spf.setStringList("MusicFiles", []);
              // Uint8List? data = await playerProvider.audioQuery.queryArtwork(activeAudioFile.id, ArtworkType.AUDIO);
              // final directory = await getApplicationDocumentsDirectory();

              // // File fileData = File('${directory.path}/demo-art.png');
              // // await fileData.writeAsBytes(data!);
              // // // print(File.fromRawPath(data!).path);
              // // print(fileData.path);
              // print(directory.listSync().length);

              // for (var item in directory.listSync(recursive: true)) {
              // print("item.path");
              // }
            },
            icon: Icon(Icons.more_vert_rounded, size: 30, color: Colors.grey.shade800),
          ),
        ],
      ),
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
                  Hero(
                    tag: 'Album',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      // child: QueryArtworkWidget(
                      //   // controller: _audioQuery,
                      //   artworkHeight: 300,
                      //   artworkWidth: size.width * 0.80,
                      //   id: activeAudioFile.id,
                      //   type: ArtworkType.AUDIO,
                      //   artworkBorder: BorderRadius.circular(12),
                      //   quality: 100,
                      //   artworkQuality: FilterQuality.high,
                      //   artworkFit: BoxFit.contain,
                      // ),
                      child: Image.file(
                        File.fromUri(Uri.file(activeAudioFile.albumArtUrl)),
                        height: 300,
                        width: size.width * 0.80,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.audio_file, size: 56);
                        },
                      ),
                    ),
                  ),
                  // Track Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activeAudioFile.title,
                        style: const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Text(
                        activeAudioFile.artist.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  // Playback Timeline
                ],
              ),
              Column(
                children: [
                  // Playback Timeline
                  // Song playback position in Duration
                  StreamBuilder<Duration>(
                      stream: playerProvider.player.positionStream,
                      builder: (context, positionStream) {
                        if (positionStream.hasData) {
                          return StreamBuilder<Duration?>(
                            // current playing song Duration
                            stream: playerProvider.player.durationStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
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
                                        max: snapshot.data!.inSeconds.toDouble(),
                                        value: positionStream.data!.inSeconds.toDouble(),
                                        onChanged: (newPosition) {
                                          playerProvider.player.seek(Duration(seconds: newPosition.toInt()));
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Current Position
                                          MusicDurationWidget(songDurationInMilliseconds: positionStream.data!.inMilliseconds),
                                          // Current Playing Song Duration
                                          MusicDurationWidget(songDurationInMilliseconds: snapshot.data!.inMilliseconds),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                              return Container();
                            },
                          );
                        }

                        return const Text("data");
                      }),
                  // Playback Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShuffleButton(
                        isShuffleOn: false,
                        onChange: (newValue) {},
                      ),
                      IconButton(
                        onPressed: () {
                          if (playerProvider.player.hasPrevious) {
                            log("Prev Track Idx: ${playerProvider.player.hasNext}");
                            playerProvider.player.seekToPrevious();
                            // activeAudioFileIndex--;
                            playerProvider.setActiveTrackIndex(playerProvider.activeTrackIndex - 1);
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.skip_previous_rounded, size: 34),
                      ),
                      StreamBuilder<PlayerState>(
                        stream: playerProvider.player.playerStateStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return PlayButton(
                              iconSize: 48,
                              isPlaying: snapshot.data!.playing,
                              onTap: () {
                                if (snapshot.data!.playing) {
                                  playerProvider.player.pause();
                                  return;
                                }
                                playerProvider.player.play();
                              },
                            );
                          }
                          return PlayButton(isPlaying: false, onTap: () {});
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          if (playerProvider.player.hasNext) {
                            log("Next Track Idx: ${playerProvider.player.hasNext}");
                            playerProvider.player.seekToNext();
                            // activeAudioFileIndex++;
                            playerProvider.setActiveTrackIndex(playerProvider.activeTrackIndex + 1);
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.skip_next_rounded, size: 34),
                      ),
                      RepeatButton(
                        isRepeatOn: false,
                        onChange: (newValue) {},
                      ),
                    ],
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
