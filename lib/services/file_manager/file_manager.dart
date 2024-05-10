import 'dart:io';
import 'dart:developer';
import 'dart:typed_data';
import 'package:music_player/global_const.dart';
import 'package:music_player/model/audio_file_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FileManager {
  /// to get all of music files from the device
  static Future<List<AudioFile>> getAllMusicFiles() async {
    final OnAudioQuery audioQuery = OnAudioQuery();
    bool isPermissionGranted = await audioQuery.checkAndRequest();
    if (isPermissionGranted) {
      log("Querying Songs From Device");
      List<SongModel> listOfSongModels = await audioQuery.querySongs();
      List<AudioFile> listSongFilesToSend = [];

      // Saving AlbumArt to Offline Storage
      await saveAlbumArtsToCacheDirectory(listOfSongModels);
      String albumArtDirectory = await GlobalConst.getAlbumArtDirectory();

      for (SongModel songInfo in listOfSongModels) {
        listSongFilesToSend.add(
          AudioFile(
            id: songInfo.id,
            title: songInfo.title,
            artist: songInfo.artist ?? "NA",
            audioPath: songInfo.data,
            albumArtUrl: "$albumArtDirectory/${songInfo.id}.png", // at this place albumArt Should be
            duration: songInfo.duration ?? -1,
            size: songInfo.size,
          ),
        );
      }
      log("Got Songs From Device Count: ${listSongFilesToSend.length}");
      return listSongFilesToSend;
    }

    return [];
  }

  static Future<List<String>> saveAlbumArtsToCacheDirectory(List<SongModel> listOfAudioFiles) async {
    final OnAudioQuery audioQuery = OnAudioQuery();
    List<String> listOfSavedAlbumArtPath = [];
    String fullPathToStoreAlbumArts = await GlobalConst.getAlbumArtDirectory();

    for (var audioFile in listOfAudioFiles) {
      Uint8List? data = await audioQuery.queryArtwork(audioFile.id, ArtworkType.AUDIO);

      if (data != null) {
        File fileData = await File('$fullPathToStoreAlbumArts/${audioFile.id}.png').create(recursive: true);
        File fileAfterSaved = await fileData.writeAsBytes(data);

        listOfSavedAlbumArtPath.add(fileAfterSaved.path);
        log("Saved Song AlbumArt at: ${fileAfterSaved.path}");
      }
    }

    return listOfSavedAlbumArtPath;
  }
}
