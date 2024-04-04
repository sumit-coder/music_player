import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/services/file_manager/file_manager.dart';
import 'package:music_player/views/player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    // var fileManagerProvider = Provider.of<FileManager>(context, listen: false);
    // fileManagerProvider.initFiles();
    super.initState();
  }

  List<SongModel> listFiles = [];

  final player = AudioPlayer();
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    var fileManagerProvider = Provider.of<FileManager>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            child: Center(
              child: TextButton(
                child: Text("data"),
                onPressed: () async {
                  listFiles = await _audioQuery.querySongs();

                  setState(() {});
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listFiles.length,
              itemBuilder: (context, index) {
                // print('object');
                return ListTile(
                  onTap: () {
                    // player.setFilePath(listFiles[index].data);
                    // player.play();
                    print(listFiles[index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScreen(
                          songInfo: listFiles[index],
                        ),
                      ),
                    );
                  },
                  leading: QueryArtworkWidget(
                    controller: _audioQuery,
                    id: listFiles[index].id,
                    type: ArtworkType.AUDIO,
                  ),
                  // leading: Image.file(file),
                  title: Text(
                    listFiles[index].title.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
