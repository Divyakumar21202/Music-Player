// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:music_player/constants/colors.dart';
import 'package:music_player/constants/widgets/bottom_nav_bar.dart';

class SongScreen extends StatefulWidget {
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
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  late final AudioPlayer audioPlayer;
  late final Source audioSource;
  Duration total = Duration.zero;
  Duration progress = Duration.zero;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  bool isPlay = false;
  Future initPlayer() async {
    print('init state  is called');
    audioPlayer = AudioPlayer();
    audioSource = UrlSource(widget.url);
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
      setState(() {});
    } else {
      audioPlayer.play(audioSource);
      isPlay = true;
      setState(() {});
    }
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        title: const Text('Best Songs Ever'),
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
                  CarouselSlider(
                    items: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.imgUrl,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.5,
                      initialPage: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
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
                  const Spacer(),
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
