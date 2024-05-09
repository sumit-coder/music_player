import 'dart:convert';

import 'package:music_player/global_const.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineDB {
  static Future<List<SongModel>> getMusicInfoFromOfflineDB() async {
    // Obtain shared preferences.
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<SongModel> dataToSend = [];

    List<String> listOfSongInfo = await sharedPreferences.getStringList(GlobalConst.offlineMusicInfoDbName) ?? [];

    for (var songInfo in listOfSongInfo) {
      // decode offline saved SongModel Info
      dataToSend.add(SongModel(json.decode(songInfo)));
    }

    return dataToSend;
  }

  static setMusicInfoToOfflineDB(List<SongModel> data) async {
    // Obtain shared preferences.
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> dataToStore = [];

    for (var songInfo in data) {
      dataToStore.add(songInfo.toString());
    }

    await sharedPreferences.setStringList(GlobalConst.offlineMusicInfoDbName, dataToStore);
  }
}
