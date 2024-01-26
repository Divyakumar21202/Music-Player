// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/models/song_model.dart';

final audioPlayerProvider = StateNotifierProvider<AudioNotifier, MyAudioPalyer>(
  (ref) => AudioNotifier(),
);

class MyAudioPalyer {
  final AudioPlayer audioPlayer;
  final bool isPlay;
  final Source source;
  final Duration audioDuration;
  final Duration progress;
  final String url;
  final String imgUrl;
  final String title;
  final String uploadedby;
  final String artist;
  final int indexedSong;
  final List<SongModel> listsongModel;

  MyAudioPalyer({
    required this.audioPlayer,
    required this.isPlay,
    required this.source,
    required this.audioDuration,
    required this.progress,
    required this.url,
    required this.imgUrl,
    required this.title,
    required this.uploadedby,
    required this.artist,
    required this.indexedSong,
    required this.listsongModel,
  });

  MyAudioPalyer copyWith({
    AudioPlayer? audioPlayer,
    bool? isPlay,
    Source? source,
    Duration? audioDuration,
    Duration? progress,
    String? url,
    String? imgUrl,
    String? title,
    String? uploadedby,
    String? artist,
    int? indexedSong,
    List<SongModel>? listsongModel,
  }) {
    return MyAudioPalyer(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isPlay: isPlay ?? this.isPlay,
      source: source ?? this.source,
      audioDuration: audioDuration ?? this.audioDuration,
      progress: progress ?? this.progress,
      url: url ?? this.url,
      imgUrl: imgUrl ?? this.imgUrl,
      title: title ?? this.title,
      uploadedby: uploadedby ?? this.uploadedby,
      artist: artist ?? this.artist,
      indexedSong: indexedSong ?? this.indexedSong,
      listsongModel: listsongModel ?? this.listsongModel,
    );
  }
}

class AudioNotifier extends StateNotifier<MyAudioPalyer> {
  AudioNotifier()
      : super(
          MyAudioPalyer(
            audioPlayer: AudioPlayer(),
            isPlay: false,
            source: UrlSource('this is the url'),
            audioDuration: const Duration(seconds: 0),
            progress: const Duration(seconds: 0),
            imgUrl: '',
            url: '',
            artist: '',
            title: '',
            uploadedby: '',
            listsongModel: [],
            indexedSong: 0,
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

  void updateSongList(List<SongModel> model) {
    state = state.copyWith(listsongModel: model);
  }

  void onDisposePlayer() {
    state.audioPlayer.dispose();
    state = state.copyWith(audioPlayer: AudioPlayer());
  }

  void isPlay() async {
    if (state.isPlay) {
      await state.audioPlayer.pause();
      Duration? duration = await state.audioPlayer.getDuration();
      Duration? progress = await state.audioPlayer.getCurrentPosition();
      duration = duration ?? Duration.zero;
      progress = progress ?? Duration.zero;
      state = state.copyWith(
        isPlay: false,
        audioDuration: duration,
        progress: progress,
      );
    } else {
      await state.audioPlayer.play(state.source);
      Duration? duration = await state.audioPlayer.getDuration();
      Duration? progress = await state.audioPlayer.getCurrentPosition();
      duration = duration ?? Duration.zero;
      progress = progress ?? Duration.zero;
      state = state.copyWith(
        isPlay: true,
        audioDuration: duration,
        progress: progress,
      );
    }
  }

  void changeSong({
    required String url,
    required String uploadedBy,
    required String imageUrl,
    required String title,
    required String artist,
    required int indexedSong,
  }) async {
    await state.audioPlayer.pause();
    await state.audioPlayer.dispose();
    state = MyAudioPalyer(
      audioPlayer: AudioPlayer(),
      isPlay: false,
      source: UrlSource(url),
      audioDuration: Duration.zero,
      progress: Duration.zero,
      url: url,
      imgUrl: imageUrl,
      title: title,
      indexedSong: indexedSong,
      uploadedby: uploadedBy,
      artist: artist,
      listsongModel: state.listsongModel,
    );
    isPlay();
  }
}
