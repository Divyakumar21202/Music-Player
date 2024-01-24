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

  Future getJson() async {
    print('getJson is called');
    try {
      print('try block');
      var res = await http.get(
        Uri.parse(
          'http://192.168.137.79:3000/get-buffer?number=50',
        ),
      );
      print('this is the status code : \n\n');
      print(res.statusCode);
      if (res.statusCode == 200) {
        List<dynamic> jsonData = json.decode(res.body);
        List<SongModel> songList = [];
        for (var item in jsonData) {
          String title = item['title'];
          String artist = item['artist'];
          String songUrl = item['artist'];
          String coverUrl = item['artist'];
          String uploadedby = item['uploadedBy'];
          songList.add(
            SongModel(
              title: title,
              description: artist,
              songUrl: songUrl,
              coverUrl: coverUrl,
              uploadedby: uploadedby,
            ),
          );
          print('Title: $title, Artist: $artist\n\n');
        }
      }
    } catch (e) {
      print('this is the error:\n\n');
      print(e.toString());
    }
  }

  // This widget is the root of your application.
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
