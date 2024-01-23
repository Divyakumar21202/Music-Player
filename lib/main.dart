import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/Screens/playlist_screen.dart';
import 'package:music_player/Screens/song_screen.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Music App',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                http.Response res = await http.get(
                    Uri.parse('http://172.22.2.203:3000/get-buffer?number=50'));
                List<Map<String, dynamic>> list = json.decode(res.body);
                print(list[0]['title']);
                print(res.statusCode);
              },
              child: const Text('Tap Here')),
        ),
      ),
    );
  }
}
