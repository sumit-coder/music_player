class AudioFile {
  int? id;
  String? title;
  String? artist;
  String? audioPath;
  String? albumArtUrl;
  int? duration;
  int? size;

  AudioFile({this.id, this.title, this.artist, this.audioPath, this.albumArtUrl, this.duration, this.size});

  AudioFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    artist = json['artist'];
    audioPath = json['audioPath'];
    albumArtUrl = json['albumArtUrl'];
    duration = json['duration'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['artist'] = artist;
    data['audioPath'] = audioPath;
    data['albumArtUrl'] = albumArtUrl;
    data['duration'] = duration;
    data['size'] = size;
    return data;
  }
}
