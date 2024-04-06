import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FileManager with ChangeNotifier {
  List<SongModel> listFiles = [];
  final OnAudioQuery audioQuery = OnAudioQuery();

  getAllMusicFiles() async {
    bool isPermissionGranted = await audioQuery.checkAndRequest();
    if (isPermissionGranted) {
      listFiles = await audioQuery.querySongs();
    }

    notifyListeners();
  }

  // initFiles() async {
  //   var directory = await getDownloadsDirectory();
  //   // print(desktopFiles);
  //   desktopFiles = Directory("storage/emulated/0/").listSync(recursive: true);
  //   // desktopFiles = directory!.listSync(recursive: true);
  //   print(desktopFiles.toString() + "asdf");
  //   if (desktopFiles != null) {
  //     for (var fileInfo in desktopFiles!) {
  //       String filePath = fileInfo.path;
  //       String fileName = filePath.split("/").last;
  //       String fileType = fileName.split(".").last;

  //       if (fileType == 'mp3') {
  //         listFiles.add({'filePath': filePath, 'fileName': fileName, 'fileType': fileType});
  //       }
  //     }
  //   }
  //   notifyListeners();
  // }
}
