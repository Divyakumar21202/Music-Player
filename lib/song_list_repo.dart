// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/models/song_model.dart';
import 'package:http/http.dart' as http;

final songListProvider = StateNotifierProvider((ref) => SongListNotifier());

class SongList {
  final List<SongModel> songList;
  SongList({
    required this.songList,
  });

  SongList copyWith({
    List<SongModel>? songList,
  }) {
    return SongList(
      songList: songList ?? this.songList,
    );
  }
}

class SongListNotifier extends StateNotifier<AsyncValue<List<SongModel>>> {
  SongListNotifier() : super(const AsyncValue.loading()) {
    listModel();
  }

  Future listModel() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => getJson());
  }

  String url =
      'https://tunescape-mono-backend.onrender.com/get-buffer?number=50';
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
      throw(e.toString());
    }
    return songList;
  }
}