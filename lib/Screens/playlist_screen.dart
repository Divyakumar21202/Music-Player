import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/features/playList/repository/playlist_repo.dart';
import 'package:music_player/models/song_model.dart';
import 'package:http/http.dart' as http;

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PlayListScreen extends ConsumerWidget {
  const PlayListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String url =
        'https://d1dgwvpmn80wva.cloudfront.net/faa52c7366ef11332a8b8a5700b46518';
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
              future: ref.watch(PlayListProvider).getSongList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: TextButton(
                      onPressed: () async {
                        http.Response res = await http.get(Uri.parse(
                            'http://172.22.2.203:3000/get-buffer?number=50',),);
                        print(res.statusCode);
                        print(res.body.length);
                      },
                      child: const Text(
                        'Loading...',
                        style: TextStyle(
                          color: progressBarColor,
                        ),
                      ),
                    ),
                  );
                }

                List<SongModel> list = [];
                if (snapshot.data != null) {
                  list = snapshot.data!;
                }
                return Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        SongModel model = list[index];
                        return Container(
                          margin: const EdgeInsets.only(
                            right: 12,
                          ),
                          height: 175,
                          width: 121,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 121,
                                width: 121,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(model.coverUrl),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                model.title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                model.description,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }),
        ),
      ),
    );
  }
}
