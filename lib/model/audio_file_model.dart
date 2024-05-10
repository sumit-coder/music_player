class AudioFile {
  late int id;
  late String title;
  late String artist;
  late String audioPath;
  late String albumArtUrl;
  late int duration;
  late int size;

  AudioFile({
    required this.id,
    required this.title,
    required this.artist,
    required this.audioPath,
    required this.albumArtUrl,
    required this.duration,
    required this.size,
  });

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
