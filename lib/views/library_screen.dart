import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player/views/widgets/music_duration_widget.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player/views/player_screen.dart';
import 'package:music_player/services/file_manager/file_manager.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    var fileManagerProvider = Provider.of<FileManager>(context);
    return Scaffold(
      body: SafeArea(
        child: fileManagerProvider.listFiles.isEmpty
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
                        fileManagerProvider.getAllMusicFiles();
                      },
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: fileManagerProvider.listFiles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      print(fileManagerProvider.listFiles[index]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                            songInfo: fileManagerProvider.listFiles[index],
                          ),
                        ),
                      );
                    },
                    leading: QueryArtworkWidget(
                      controller: fileManagerProvider.audioQuery,
                      id: fileManagerProvider.listFiles[index].id,
                      type: ArtworkType.AUDIO,
                    ),
                    title: Text(
                      fileManagerProvider.listFiles[index].title.toString(),
                      maxLines: 1,
                      style: TextStyle(color: Colors.grey),
                    ),
                    subtitle: Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 200),
                          child: Text(
                            fileManagerProvider.listFiles[index].artist.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(" - "),
                        MusicDurationWidget(songDurationInMilliseconds: fileManagerProvider.listFiles[index].duration ?? 0),
                        // Text(Duration(milliseconds: fileManagerProvider.listFiles[index].duration ?? 0).inMinutes.toString()),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
