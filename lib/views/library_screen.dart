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
                    color: Color.fromARGB(255, 23, 23, 23),
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
            : ListView.builder(
                itemCount: playerProvider.listAudioFiles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      playerProvider.player.seek(Duration.zero, index: index);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(
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
                      style: TextStyle(color: Colors.grey),
                    ),
                    subtitle: Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 200),
                          child: Text(
                            playerProvider.listAudioFiles[index].artist.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(" - "),
                        MusicDurationWidget(songDurationInMilliseconds: playerProvider.listAudioFiles[index].duration ?? 0),
                        // Text(Duration(milliseconds: playerProvider.listFiles[index].duration ?? 0).inMinutes.toString()),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
