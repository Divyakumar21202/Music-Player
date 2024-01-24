import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/Screens/playlist_screen.dart';
import 'package:music_player/Screens/song_screen.dart';
import 'package:http/http.dart' as http;
import 'package:music_player/models/song_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Music App',
      theme: ThemeData.dark(),
      home: const PlayListScreen(),
    );
  }
}
