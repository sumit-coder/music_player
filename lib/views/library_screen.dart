import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/services/file_manager/file_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
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
            child: Center(
              child: TextButton(
                child: Text("data"),
                onPressed: () async {
                  List<SongModel> listFiles = await _audioQuery.querySongs();
                  print(listFiles);
                  setState(() {});
                  // if (await Permission.manageExternalStorage.request().isGranted) {
                  //   print("object");
                  // }
                  // await Permission.storage.request();
                  // var status = await Permission.storage.status;
                  // print(status);
                  // if (status.isDenied) {
                  //   // We haven't asked for permission yet or the permission has been denied before, but not permanently.
                  // }
                  // fileManagerProvider.initFiles();
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
                    player.setFilePath(listFiles[index].data);
                    player.play();
                  },
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
