// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final musicPlayRepositoryProvide = Provider(
  (ref) => MusicPlayRepository(
    player: AudioPlayer(),
  ),
);

class MusicPlayRepository {
  AudioPlayer player;
  MusicPlayRepository({
    required this.player,
  });
  Stream durationTime() {
    return player.onDurationChanged;
  }

  Stream durationPosition() {
    return player.onPositionChanged;
  }

  Stream onFinished() {
    return player.onPlayerComplete;
  }
}
