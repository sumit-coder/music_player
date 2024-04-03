import 'package:flutter/material.dart';
import 'package:music_player/services/file_manager/file_manager.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    var fileManagerProvider = Provider.of<FileManager>(context, listen: false);
    fileManagerProvider.initFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fileManagerProvider = Provider.of<FileManager>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: fileManagerProvider.listFiles.length,
        itemBuilder: (context, index) {
          return ListTile(
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
