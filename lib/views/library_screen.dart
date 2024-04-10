import 'package:flutter/material.dart';
import 'package:music_player/providers/player_provider.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player/views/player_screen.dart';
import 'package:music_player/views/widgets/music_duration_widget.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    var playerProvider = Provider.of<PlayerProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: playerProvider.listAudioFiles.isEmpty
            ? Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 23, 23, 23),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 54,
                  width: 200,
                  child: Center(
                    child: TextButton(
                      child: const Text(
                        "Get All Music",
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () async {
                        playerProvider.getAllMusicFiles();
                      },
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  ListView.builder(
                    itemCount: playerProvider.listAudioFiles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          playerProvider.player.seek(Duration.zero, index: index);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerScreen(
                                selectedIndex: index,
                                songInfo: playerProvider.listAudioFiles[index],
                              ),
                            ),
                          );
                        },
                        leading: QueryArtworkWidget(
                          controller: playerProvider.audioQuery,
                          id: playerProvider.listAudioFiles[index].id,
                          type: ArtworkType.AUDIO,
                        ),
                        title: Text(
                          playerProvider.listAudioFiles[index].title.toString(),
                          maxLines: 1,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        subtitle: Row(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Text(
                                playerProvider.listAudioFiles[index].artist.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Text(" - "),
                            MusicDurationWidget(songDurationInMilliseconds: playerProvider.listAudioFiles[index].duration ?? 0),
                            // Text(Duration(milliseconds: playerProvider.listFiles[index].duration ?? 0).inMinutes.toString()),
                          ],
                        ),
                      );
                    },
                  ),
                  // Current Playing Song Info
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 68,
                      color: Colors.grey.shade700,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              QueryArtworkWidget(
                                controller: playerProvider.audioQuery,
                                id: playerProvider.listAudioFiles[0].id,
                                type: ArtworkType.AUDIO,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(playerProvider.listAudioFiles[0].title),
                                  Text(playerProvider.listAudioFiles[0].artist!),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                style: const ButtonStyle(
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
                                ),
                                onPressed: () {},
                                icon: const Icon(Icons.play_arrow_rounded, size: 38),
                              ),
                              IconButton(
                                // padding: EdgeInsets.zero,
                                // constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: const Icon(Icons.skip_next_rounded),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
