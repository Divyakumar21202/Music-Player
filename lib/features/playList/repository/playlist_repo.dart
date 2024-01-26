import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/Screens/song_screen.dart';
import 'package:music_player/models/song_model.dart';
import 'package:http/http.dart' as http;

final playListProvider = Provider(
  (ref) => PlayList(
    url: 'https://tunescape-mono-backend.onrender.com/get-buffer?number=50',
  ),
);

class PlayList {
  final String url;
  PlayList({
    required this.url,
  });

  Future<List<SongModel>> getJson() async {
    List<SongModel> songList = [];
    try {
      var res = await http.get(
        Uri.parse(
          url,
        ),
      );
      if (res.statusCode == 200) {
        List<dynamic> jsonData = json.decode(res.body);
        for (var item in jsonData) {
          String title = item['title'];
          String artist = item['artist'];
          String uploadedBy = item['uploadedBy'];
          String songUrl =
              'https://d1dgwvpmn80wva.cloudfront.net/${item['musicHash']}';
          String coverUrl =
              'https://d1dgwvpmn80wva.cloudfront.net/${item['thumbnailHash']}';
          songList.add(
            SongModel(
              title: title,
              description: artist,
              songUrl: songUrl,
              coverUrl: coverUrl,
              uploadedby: uploadedBy,
            ),
          );
        }

        return songList;
      }
    } catch (e) {
      print(e.toString());
    }
    return songList;
  }
   Future<List<RotationSong>> getRotationList() async {
    List<RotationSong> rotationSongList = [];
    try {
      var res = await http.get(
        Uri.parse(
          url,
        ),
      );
      if (res.statusCode == 200) {
        List<dynamic> jsonData = json.decode(res.body);
        for (var item in jsonData) {
          String title = item['title'];
          String artist = item['artist'];
          String uploadedBy = item['uploadedBy'];
          String songUrl =
              'https://d1dgwvpmn80wva.cloudfront.net/${item['musicHash']}';
          String coverUrl =
              'https://d1dgwvpmn80wva.cloudfront.net/${item['thumbnailHash']}';
          rotationSongList.add(
           RotationSong(model:  SongModel(
              title: title,
              description: artist,
              songUrl: songUrl,
              coverUrl: coverUrl,
              uploadedby: uploadedBy,
            ),)
          );
        }

        return rotationSongList;
      }
    } catch (e) {
      print(e.toString());
    }
    return rotationSongList;
  }

}
