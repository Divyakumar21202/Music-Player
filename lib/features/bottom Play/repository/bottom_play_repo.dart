// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomPlayRepositoryProider = StateProvider<BottomPlay>(
  (ref) => BottomPlay(
    bottomPlayer: AudioPlayer(),
    isPlay: false,
    duration: const Duration(seconds: 0),
    progress: const Duration(
      seconds: 0,
    ),
    url:
        'https://d1dgwvpmn80wva.cloudfront.net/e8a20ab51a6124da899acdf35bfdc74b',
    source: UrlSource(
        'https://d1dgwvpmn80wva.cloudfront.net/e8a20ab51a6124da899acdf35bfdc74b'),
  ),
);

class BottomPlay {
  final AudioPlayer bottomPlayer;
  final bool isPlay;
  final Duration duration;
  final Duration progress;
  final Source source;
  final String url;
  BottomPlay({
    required this.bottomPlayer,
    required this.isPlay,
    required this.duration,
    required this.progress,
    required this.source,
    required this.url,
  });

  BottomPlay playPause() {
    if (isPlay) {
      bottomPlayer.pause();
      return BottomPlay(
        bottomPlayer: bottomPlayer,
        isPlay: !isPlay,
        duration: duration,
        progress: progress,
        source: source,
        url: url,
      );
    } else {
      bottomPlayer.play(source);
      return BottomPlay(
        bottomPlayer: bottomPlayer,
        isPlay: !isPlay,
        duration: duration,
        progress: progress,
        source: source,
        url: url,
      );
    }
  }
}
