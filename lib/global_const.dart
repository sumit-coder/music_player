import 'package:path_provider/path_provider.dart';

class GlobalConst {
  static const String albumArtsPath = "";
  static const String offlineMusicInfoDbName = "MusicFiles";
  static const String musicAlbumArtCacheFolderName = "AlbumArt";

  static Future<String> getAlbumArtDirectory() async {
    var directory = await getApplicationCacheDirectory();

    String fullPathToStoreAlbumArts = "${directory.path}/$musicAlbumArtCacheFolderName";

    return fullPathToStoreAlbumArts;
  }
}
