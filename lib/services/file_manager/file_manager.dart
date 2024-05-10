import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:music_player/global_const.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  /// to get all of music files from the device
  static Future<List<SongModel>> getAllMusicFiles() async {
    final OnAudioQuery audioQuery = OnAudioQuery();
    bool isPermissionGranted = await audioQuery.checkAndRequest();
    if (isPermissionGranted) {
      List<SongModel> listFiles = await audioQuery.querySongs();

      await saveAlbumArtsToCacheDirectory(listFiles);
      return listFiles;
    }

    return [];
  }

  static Future<List<String>> saveAlbumArtsToCacheDirectory(List<SongModel> listOfAudioFiles) async {
    final OnAudioQuery audioQuery = OnAudioQuery();
    List<String> listOfSavedAlbumArtPath = [];
    var directory = await getApplicationCacheDirectory();
    String fullPathToStoreAlbumArts = await GlobalConst.getAlbumArtDirectory();

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
