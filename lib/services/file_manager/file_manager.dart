import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileManager with ChangeNotifier {
  List<FileSystemEntity>? desktopFiles;
  List<Map<String, dynamic>> listFiles = [];

  initFiles() async {
    var directory = await getDownloadsDirectory();
    // print(desktopFiles);
    desktopFiles = Directory("storage/emulated/0/").listSync(recursive: true);
    // desktopFiles = directory!.listSync(recursive: true);
    print(desktopFiles.toString() + "asdf");
    if (desktopFiles != null) {
      for (var fileInfo in desktopFiles!) {
        String filePath = fileInfo.path;
        String fileName = filePath.split("/").last;
        String fileType = fileName.split(".").last;

        if (fileType == 'mp3') {
          listFiles.add({'filePath': filePath, 'fileName': fileName, 'fileType': fileType});
        }
      }
    }
    notifyListeners();
  }
}
