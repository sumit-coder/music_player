import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
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

    List<AudioSource> listOfAudioSources = [];

    for (var audioInfo in listAudioFiles) {
      Uint8List? artWork = await audioQuery.queryArtwork(audioInfo.id, ArtworkType.AUDIO);

      listOfAudioSources.add(AudioSource.uri(
        Uri.file(audioInfo.data),
        tag: MediaItem(
          id: '${audioInfo.albumId}',
          album: audioInfo.album ?? "NA",
          title: audioInfo.title,
          artUri: artWork != null ? Uri.file(File.fromRawPath(artWork).path) : null,
        ),
      ));
    }

    player.setAudioSource(
      ConcatenatingAudioSource(children: listOfAudioSources
          // children: [
          //   for (SongModel filePath in listAudioFiles)
          // AudioSource.uri(
          //   Uri.file(filePath.data),
          //   tag: MediaItem(
          //     id: '${filePath.albumId}',
          //     album: filePath.album ?? "NA",
          //     title: filePath.title,
          //     artUri: Uri.file(audioQuery.),
          //   ),
          // ),
          // ],
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
