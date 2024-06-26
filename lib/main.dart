import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/providers/player_provider.dart';
import 'package:music_player/views/library_screen.dart';
import 'package:provider/provider.dart';
import 'services/file_manager/file_manager.dart';

void main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => FileManager()),
        ChangeNotifierProvider(create: (context) => PlayerProvider()),
      ],
      child: MaterialApp(
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
            background: Colors.grey.shade900,
          ),
        ),
        // home: const PlayerScreen(),
        home: const LibraryScreen(),
      ),
    );
  }
}
