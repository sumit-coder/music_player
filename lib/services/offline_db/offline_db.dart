import 'dart:convert';
import 'dart:developer';

import 'package:music_player/global_const.dart';
import 'package:music_player/services/file_manager/file_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineDB {
  static Future<List<SongModel>> getMusicInfoFromOfflineDB() async {
    // Obtain shared preferences.
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<SongModel> dataToSend = [];

    // get offline stored data List<String>
    List<String> listOfSongInfo = sharedPreferences.getStringList(GlobalConst.offlineMusicInfoDbName) ?? [];

    for (var songInfo in listOfSongInfo) {
      log(jsonEncode(songInfo));
      log(songInfo);
      // decode offline saved SongModel Info
      dataToSend.add(SongModel(json.decode(songInfo)));
    }

    return dataToSend;
  }

  // if there is no songInfo in OfflineDB then query list of songs
  // from the device and save them to OfflineDB for later use
  static Future<List<SongModel>> getMusicFromDeviceAndSaveToOfflineDB() async {
    List<SongModel> queriedSongs = await FileManager.getAllMusicFiles();

    // Send all songs to be stored in OfflineDB
    await setMusicInfoToOfflineDB(queriedSongs);

    return queriedSongs;
  }

  static setMusicInfoToOfflineDB(List<SongModel> listOfSongModels) async {
    // Obtain shared preferences.
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> dataToStore = [];

    for (var songInfo in listOfSongModels) {
      dataToStore.add(songInfo.toString());
    }

    await sharedPreferences.setStringList(GlobalConst.offlineMusicInfoDbName, dataToStore);
  }
}
