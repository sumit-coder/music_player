import 'package:flutter/material.dart';
import 'package:music_player/views/library_screen.dart';
import 'package:music_player/views/player_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
