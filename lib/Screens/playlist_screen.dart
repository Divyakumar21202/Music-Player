import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/Screens/song_screen.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/features/music%20Play/repository/music_play_repository.dart';
import 'package:music_player/features/playList/repository/playlist_repo.dart';
import 'package:music_player/models/song_model.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Trending',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: ref.watch(playListProvider).getJson(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: TextButton(
                            onPressed: () {},
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
                        // ref.read(audioPlayerProvider.notifier).updateSongList(list);
                      }
                      return Container(
                        height: 200,
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              SongModel model = list[index];
                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .watch(audioPlayerProvider.notifier)
                                      .changeSong(
                                        imageUrl: model.coverUrl,
                                        url: model.songUrl,
                                        artist: model.description,
                                        title: model.title,
                                        uploadedBy: model.uploadedby,
                                        indexedSong: index,
                                      );
                                  ref
                                      .watch(audioPlayerProvider.notifier)
                                      .updateSongList(list);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return const SongScreen();
                                    }),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 12,
                                  ),
                                  height: 175,
                                  width: 121,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 121,
                                        width: 121,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(model.coverUrl),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        model.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        model.description,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
