// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:music_player/constants/colors.dart';
import 'package:music_player/constants/widgets/bottom_nav_bar.dart';
import 'package:music_player/features/playList/repository/playlist_repo.dart';
import 'package:music_player/models/song_model.dart';
import 'package:shimmer/shimmer.dart';

class SongScreen extends ConsumerStatefulWidget {
  String url;
  String imgUrl;
  String title;
  String uploadedby;
  String artist;
  SongScreen({
    Key? key,
    required this.url,
    required this.artist,
    required this.imgUrl,
    required this.title,
    required this.uploadedby,
  }) : super(key: key);

  @override
  ConsumerState<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends ConsumerState<SongScreen> {
  late final AudioPlayer audioPlayer;
  late final Source audioSource;
  Duration total = Duration.zero;
  Duration progress = Duration.zero;
  String thisUrl = '';
  List<RotationSong> rotationSong = [];

  @override
  void initState() {
    super.initState();
    thisUrl = widget.url;
    initPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  bool isPlay = false;
  Future initPlayer() async {
    audioPlayer = AudioPlayer();
    audioSource = UrlSource(thisUrl);
    await audioPlayer.setSource(audioSource);
    audioPlayer.getDuration().then((value) {
      if (value != null) {
        setState(() {
          total = value;
        });
        return value;
      }
      return const Duration(seconds: 0);
    });
  }

  void playPause() {
    if (isPlay) {
      audioPlayer.pause();
      isPlay = false;
    } else {
      audioPlayer.play(audioSource);
      isPlay = true;
    }
  }

  int index = 0;
  Future getRSongs() async {
    rotationSong = await ref.watch(playListProvider).getRotationList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        title: const Text('Tunescape'),
        centerTitle: true,
        backgroundColor: transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.now_widgets_rounded,
            ),
            color: buttonColor,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: transparent,
              child: Column(
                children: [
                  const Spacer(),
                  Consumer(builder: (context, ref, child) {
                    return FutureBuilder(
                        future: ref.watch(playListProvider).getRotationList(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: false,
                                enlargeCenterPage: true,
                                viewportFraction: 0.5,
                                initialPage: 0,
                              ),
                              items: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      14,
                                    ),
                                  ),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade400,
                                    highlightColor: Colors.grey.shade200,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius: BorderRadius.circular(
                                          14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          List<RotationSong> listRotationSong = snapshot.data!;
                          return CarouselSlider(
                            items: listRotationSong,
                            options: CarouselOptions(
                              onPageChanged: (val, CarouselPageChangedReason) {
                                thisUrl = listRotationSong[val].model.songUrl;
                                print(thisUrl);
                                audioPlayer.pause();
                                audioPlayer.play(
                                  UrlSource(
                                    thisUrl,
                                  ),
                                );
                                isPlay = true;
                              },
                              autoPlay: false,
                              enlargeCenterPage: true,
                              viewportFraction: 0.5,
                              initialPage: 0,
                            ),
                          );
                        });
                  }),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.skip_previous_rounded,
                ),
                color: buttonColor,
                iconSize: 50,
              ),
              isPlay
                  ? IconButton(
                      onPressed: () {
                        playPause();
                      },
                      icon: const Icon(
                        Icons.pause_circle_outline_rounded,
                      ),
                      color: pauseButtonColor,
                      iconSize: 50,
                    )
                  : IconButton(
                      onPressed: () {
                        playPause();
                      },
                      icon: const Icon(
                        Icons.play_circle_outline_rounded,
                      ),
                      iconSize: 50,
                      color: playButtonColor,
                    ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.skip_next_rounded,
                ),
                color: buttonColor,
                iconSize: 50,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: StreamBuilder(
              stream: audioPlayer.onPositionChanged,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ProgressBar(
                    progress: progress,
                    total: total,
                  );
                }
                progress = Duration(seconds: snapshot.data!.inSeconds);
                return ProgressBar(
                  onSeek: (value) {
                    audioPlayer.seek(value);
                    setState(() {});
                  },
                  progressBarColor: progressBarColor,
                  buffered: const Duration(
                    seconds: 0,
                  ),
                  bufferedBarColor: Colors.grey,
                  progress: progress,
                  total: total,
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class RotationSong extends StatelessWidget {
  final SongModel model;
  const RotationSong({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            model.coverUrl,
          ),
        ),
        borderRadius: BorderRadius.circular(
          14,
        ),
      ),
    );
  }
}
/*
 FutureBuilder(
                        future: ref.watch(playListProvider).getJson(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(
                                    14,
                                  ),
                                ),
                              ),
                            );
                          }
                          return CarouselSlider(
                            items: [
                              FutureBuilder(
                                  future: ref.watch(playListProvider).getJson(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey.shade200,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/error.jpg',
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                      );
                                    }
                                    // List<SongModel> songList = snapshot.data!;
                                    // return ListView.builder(
                                    //     itemCount: songList.length,
                                    //     itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            'https://d1dgwvpmn80wva.cloudfront.net/faa52c7366ef11332a8b8a5700b46518',
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          14,
                                        ),
                                      ),
                                    );
                                    // });
                                  }),
                            ],
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              viewportFraction: 0.5,
                              initialPage: 0,
                            ),
                          );
                        });
                 
*/


/*
FutureBuilder(
                        future: ref.watch(playListProvider).getJson(),
                        builder: (context, snapshot) {
                          if (ConnectionState.waiting ==
                              snapshot.connectionState) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(
                                    14,
                                  ),
                                ),
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/error.jpg',
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                      );
                                    }
                          
                          List<SongModel> songList = snapshot.data!;
                          List<RotationSong> rotateList = [];
                          for (var model in songList) {
                            rotateList.add(RotationSong(model: model));
                          }
                          return CarouselSlider(
                            items: rotateList,
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              viewportFraction: 0.5,
                              initialPage: 0,
                            ),
                          );
                        });
                 */


                /* const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.artist,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.uploadedby,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const Spacer(), */