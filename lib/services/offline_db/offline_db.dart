import 'dart:convert';
import 'dart:developer';
import 'package:music_player/global_const.dart';
import 'package:music_player/model/audio_file_model.dart';
import 'package:music_player/services/file_manager/file_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineDB {
  static Future<List<AudioFile>> getMusicInfoFromOfflineDB() async {
    // Obtain shared preferences.
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<AudioFile> dataToSend = [];

    // get offline stored data List<String>
    List<String> listOfSongInfo = sharedPreferences.getStringList(GlobalConst.offlineMusicInfoDbName) ?? [];

    for (var songInfo in listOfSongInfo) {
      log("Song From OfflineDB: $songInfo");
      // decode offline saved AudioFile Info
      dataToSend.add(AudioFile.fromJson(json.decode(songInfo)));
    }

    return dataToSend;
  }

  // if there is no songInfo in OfflineDB then query list of songs
  // from the device and save them to OfflineDB for later use
  static Future<List<AudioFile>> getMusicFromDeviceAndSaveToOfflineDB() async {
    List<AudioFile> queriedSongs = await FileManager.getAllMusicFiles();

    log("Got All of Song from Device Count: ${queriedSongs.length}");
    // Send all songs to be stored in OfflineDB
    await setMusicInfoToOfflineDB(queriedSongs);

    return queriedSongs;
  }

  static setMusicInfoToOfflineDB(List<AudioFile> listOfSongModels) async {
    // Obtain shared preferences.
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> dataToStore = [];

    for (AudioFile songInfo in listOfSongModels) {
      dataToStore.add(json.encode(songInfo.toJson()));
    }

    await sharedPreferences.setStringList(GlobalConst.offlineMusicInfoDbName, dataToStore);
    log("Saved Songs to OfflineDB Count: ${dataToStore.length}");
  }
}
