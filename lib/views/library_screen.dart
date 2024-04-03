import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/services/file_manager/file_manager.dart';
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

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    var fileManagerProvider = Provider.of<FileManager>(context);
    return Scaffold(
      body: fileManagerProvider.listFiles.isEmpty
          ? Container(
              child: Center(
                child: TextButton(
                  child: Text("data"),
                  onPressed: () async {
                    Permission.storage.request();
                    var status = await Permission.storage.status;
                    print(status);
                    if (status.isDenied) {
                      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
                    }
                    fileManagerProvider.initFiles();
                  },
                ),
              ),
            )
          : ListView.builder(
              itemCount: fileManagerProvider.listFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    player.setFilePath(fileManagerProvider.listFiles[index]['filePath']);
                    player.play();
                  },
                  title: Text(
                    fileManagerProvider.listFiles[index]['fileName'],
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                );
              },
            ),
    );
  }
}
