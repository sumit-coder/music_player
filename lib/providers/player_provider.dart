import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/global_const.dart';
import 'package:music_player/model/audio_file_model.dart';
import 'package:music_player/services/offline_db/offline_db.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerProvider with ChangeNotifier {
  List<AudioFile> listAudioFiles = [];
  OnAudioQuery audioQuery = OnAudioQuery();
  AudioPlayer player = AudioPlayer();
  int activeTrackIndex = -1;
  bool isOfflineDbEmpty = false;

  setActiveTrackIndex(int newIndex) {
    activeTrackIndex = newIndex;
    notifyListeners();
  }

  getAllMusicFilesFromOfflineDB() async {
    listAudioFiles = await OfflineDB.getMusicInfoFromOfflineDB();
    if (listAudioFiles.isEmpty) {
      isOfflineDbEmpty = true;
    }
    notifyListeners();
  }

  getAllMusicFilesFromDevice() async {
    listAudioFiles = await OfflineDB.getMusicFromDeviceAndSaveToOfflineDB();
    String fullPathToStoreAlbumArts = await GlobalConst.getAlbumArtDirectory();
    List<AudioSource> listOfAudioSources = [];

    for (var audioInfo in listAudioFiles) {
      // Uint8List? artWork = await audioQuery.queryArtwork(audioInfo.id, ArtworkType.AUDIO);

      listOfAudioSources.add(AudioSource.uri(
        Uri.file(audioInfo.audioPath),
        tag: MediaItem(
          id: '${audioInfo.id}',
          album: audioInfo.artist,
          artist: audioInfo.artist,
          title: audioInfo.title,
          artUri: Uri.file('$fullPathToStoreAlbumArts/${audioInfo.id}.png'),
        ),
      ));
    }

    player.setAudioSource(ConcatenatingAudioSource(children: listOfAudioSources));

    // listen to when song end
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
