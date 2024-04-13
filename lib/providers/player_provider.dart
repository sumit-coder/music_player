import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerProvider with ChangeNotifier {
  List<SongModel> listAudioFiles = [];
  OnAudioQuery audioQuery = OnAudioQuery();
  AudioPlayer player = AudioPlayer();
  int activeTrackIndex = -1;

  setActiveTrackIndex(int newIndex) {
    activeTrackIndex = newIndex;
    notifyListeners();
  }

  getAllMusicFiles() async {
    bool isPermissionGranted = await audioQuery.checkAndRequest();
    if (isPermissionGranted) {
      listAudioFiles = await audioQuery.querySongs();
    }

    player.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          for (SongModel filePath in listAudioFiles) AudioSource.file(filePath.data),
        ],
      ),
    );

    // listen to song end
    player.positionStream.listen((state) {
      log(state.toString());
      log(state.toString() + player.duration.toString());
      if (state == player.duration) {
        log("state".toString());
        if (player.hasNext) {
          log("state2".toString());
          activeTrackIndex++;
          notifyListeners();
        }
      }
    });

    notifyListeners();
  }
}
