import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:music_player/global_const.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileManager with ChangeNotifier {
  List<SongModel> listFiles = [];
  final OnAudioQuery audioQuery = OnAudioQuery();

  getAllMusicFiles() async {
    bool isPermissionGranted = await audioQuery.checkAndRequest();
    if (isPermissionGranted) {
      listFiles = await audioQuery.querySongs();
    }

    // Save AlbumArt for all of Music Files
    await saveAlbumArtsToCacheDirectory(listFiles);

    notifyListeners();
  }

  Future<List<String>> saveAlbumArtsToCacheDirectory(List<SongModel> listOfAudioFiles) async {
    List<String> listOfSavedAlbumArtPath = [];
    var directory = await getApplicationCacheDirectory();
    String fullPathToStoreAlbumArts = "${directory.path}/AlbumArt";

    for (var audioFile in listOfAudioFiles) {
      Uint8List? data = await audioQuery.queryArtwork(audioFile.id, ArtworkType.AUDIO);

      if (data != null) {
        File fileData = await File('$fullPathToStoreAlbumArts/${audioFile.id}.png').create(recursive: true);
        File fileAfterSaved = await fileData.writeAsBytes(data);

        listOfSavedAlbumArtPath.add(fileAfterSaved.path);
        log(fileAfterSaved.path);
      }
    }

    return listOfSavedAlbumArtPath;
  }
}
