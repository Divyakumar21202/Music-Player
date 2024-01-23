import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/models/song_model.dart';
import 'package:http/http.dart' as http;

final PlayListProvider = Provider(
  (ref) => PlayList(
    url: 'http://172.22.2.203:3000/get-buffer?number=50',
  ),
);

class PlayList {
  final String url;
  PlayList({
    required this.url,
  });

  Future<List<SongModel>> getSongList() async {
    List<SongModel> list = [];
    try {
      var response = await http.get(Uri.parse(url));
      print('\n\n\n\n\n\n\n\n\n');
      print(response.body);
      print(response.statusCode);
      print('\n\n\n\n\n\n\n\n\n');
      if (response.statusCode == 200) {
        List<int> objList = response.body.codeUnits;
        int i = 0;
        while (i <= objList.length) {
          SongModel model = SongModel(
            title: 'Khulke Jeene Ka',
            description: 'Arijit Singh ,Shasha Tirupati',
            songUrl:
                'https://d1dgwvpmn80wva.cloudfront.net/ebd7390156efc7b13eeb4b2d745f3612',
            coverUrl:
                'https://d1dgwvpmn80wva.cloudfront.net/faa52c7366ef11332a8b8a5700b46518',
          );
          list.add(model);
        }
      }
      return list;
    } catch (e) {
      throw (e.toString());
    }
  }
}

/*

_id
:
"64ff48f6e3ac3b465a8532cc"
title
:
"Khulke Jeene Ka"
artist
:
"Arijit Singh ,Shasha Tirupati"
musicHash
:
"ebd7390156efc7b13eeb4b2d745f3612"
thumbnailHash
:
"faa52c7366ef11332a8b8a5700b46518"
uploadedBy
:
"Soubhik Gon"
uid
:
"jP6dXeXeocdqdWFeAUaFLsEWEPa2"
plays
:
0
likedBy
:
[]
duration
:
"3:25"
createdAt
:
"2023-09-11T17:05:58.949Z"
updatedAt
:
"2023-09-11T17:05:58.949Z"
*/