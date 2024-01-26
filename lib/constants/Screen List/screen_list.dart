import 'package:flutter/material.dart';
import 'package:music_player/Screens/playlist_screen.dart';
import 'package:music_player/features/uploading/screens/uploading_screen.dart';

List<Widget> screenList = [
  const PlayListScreen(),
  const Scaffold(
    body: Center(
      child: Text('Screen 2'),
    ),
  ),
  const Scaffold(
    body: Center(
      child: Text('Screen 3'),
    ),
  ),
  const MusicUploadingScreen(),
];
