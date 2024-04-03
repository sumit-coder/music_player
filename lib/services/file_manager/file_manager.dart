import 'dart:io';

import 'package:flutter/material.dart';

class FileManager with ChangeNotifier {
  List<FileSystemEntity>? desktopFiles;
  List<Map<String, dynamic>> listFiles = [];

  initFiles() async {
    // directory = await getDownloadsDirectory();
    desktopFiles = Directory("C:/Users/win10/Downloads/").listSync(recursive: true);

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
  }
}
