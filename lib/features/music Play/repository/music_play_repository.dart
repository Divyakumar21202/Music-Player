// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioPlayerProvider = StateNotifierProvider<AudioNotifier, MyAudioPalyer>(
    (ref) => AudioNotifier());

class MyAudioPalyer {
  final AudioPlayer audioPlayer;
  final bool isPlay;
  final Source source;
  final Duration audioDuration;
  final Duration progress;

  MyAudioPalyer({
    required this.audioPlayer,
    required this.isPlay,
    required this.source,
    required this.audioDuration,
    required this.progress,
  });

  MyAudioPalyer copyWith({
    AudioPlayer? audioPlayer,
    bool? isPlay,
    Source? source,
    Duration? audioDuration,
    Duration? progress,
  }) {
    return MyAudioPalyer(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isPlay: isPlay ?? this.isPlay,
      source: source ?? this.source,
      audioDuration: audioDuration ?? this.audioDuration,
      progress: progress ?? this.progress,
    );
  }
}

class AudioNotifier extends StateNotifier<MyAudioPalyer> {
  AudioNotifier()
      : super(
          MyAudioPalyer(
            audioPlayer: AudioPlayer(),
            isPlay: false,
            source: AssetSource('music/mmusic.mp3'),
            audioDuration: const Duration(seconds: 0),
            progress: const Duration(seconds: 0),
          ),
        );

  Future<Duration> getDuration() async {
    Duration? duration = await state.audioPlayer.getDuration();
    duration = duration ?? Duration.zero;
    return duration;
  }

  void onSeekPlayer(Duration val) async {
    await state.audioPlayer.seek(val);
  }

  Stream<Duration> getCurrentPlayerPosition() {
    return state.audioPlayer.onPositionChanged;
  }

  void isPlay() async {
    Duration? duration = await state.audioPlayer.getDuration();
    Duration? progress = await state.audioPlayer.getCurrentPosition();
    duration = duration ?? Duration.zero;
    progress = progress ?? Duration.zero;

    if (state.isPlay) {
      await state.audioPlayer.pause();
      state = state.copyWith(
        isPlay: false,
        audioDuration: duration,
        progress: progress,
      );
    } else {
      await state.audioPlayer.play(state.source);
      state = state.copyWith(
        isPlay: true,
        audioDuration: duration,
        progress: progress,
      );
    }
  }
}

  
/*
String url;
  String imgUrl;
  String title;
  String uploadedby;
  String artist;


  state of AudioPlayer :
  bool isPlay;
  stream duration 
  stream position
  UrlSource 
  AudioPlayer() instance 

  */





