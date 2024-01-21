// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/features/music%20Play/repository/music_play_repository.dart';

final musicPlayControllerProvider = Provider(
  (ref) => MusicPlayController(
    musicPlayRepository: ref.watch(
      musicPlayRepositoryProvide,
    ),
  ),
);

class MusicPlayController {
  final MusicPlayRepository musicPlayRepository;
  MusicPlayController({
    required this.musicPlayRepository,
  });
  Stream durationTime() {
    return musicPlayRepository.durationTime();
  }

  Stream durationPosition() {
    return musicPlayRepository.durationPosition();
  }

  Stream onFinished() {
    return musicPlayRepository.onFinished();
  }
}
