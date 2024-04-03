import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Song Tilte',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          );
        },
      ),
    );
  }
}
