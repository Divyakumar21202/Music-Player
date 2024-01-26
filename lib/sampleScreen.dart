import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/features/music%20Play/repository/music_play_repository.dart';

class MyWidget extends ConsumerStatefulWidget {
  const MyWidget({super.key});

  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final audio = ref.watch(audioPlayerProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                
                IconButton(
                  onPressed: () {
                    // ref.read(audioPlayerProvider.notifier).changeSong(required);
                  },
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
                  initialData: Duration.zero,
                  stream: ref
                      .watch(audioPlayerProvider.notifier)
                      .getCurrentPlayerPosition(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ProgressBar(
                        progress: audio.progress,
                        total: audio.audioDuration,
                      );
                    }
                    return ProgressBar(
                      progress: snapshot.data!,
                      total: audio.audioDuration,
                      onSeek: (val) {
                        ref
                            .read(audioPlayerProvider.notifier)
                            .onSeekPlayer(val);
                      },
                    );
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
