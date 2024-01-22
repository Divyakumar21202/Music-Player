// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:music_player/constants/colors.dart';

class MusicPlayerWidget extends StatelessWidget {
  final double max;
  final AudioPlayer musicPlayer;
  final int value;
  final ValueChanged<double> onChanged;
  const MusicPlayerWidget({
    Key? key,
    required this.max,
    required this.onChanged,
    required this.musicPlayer,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formatMusicTime(double timeInSeconds) {
      Duration duration = Duration(seconds: timeInSeconds.round());
      final formatter = DateFormat('mm:ss');
      return formatter.format(DateTime(
          0, 1, 1, 0, duration.inMinutes, duration.inSeconds.remainder(60)));
    }

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 7),
          child: Slider(
            label: formatMusicTime(value.toDouble()),
            max: max,
            activeColor: progressBarColor,
            value: value.toDouble(),
            onChanged: (val) {
              musicPlayer.seek(
                Duration(
                  seconds: val.toInt(),
                ),
              );
              onChanged(val);
            },
          ),
        ),
        Positioned(
          bottom: -5,
          left: 24,
          child: Text(
            formatMusicTime(value.toDouble()),
            style: const TextStyle(color: musicOngoingTimeColor),
          ),
        ),
        Positioned(
          right: 24,
          bottom: -5,
          child: Text(
            formatMusicTime(max),
            style: const TextStyle(color: musicDurationColor),
          ),
        ),
      ],
    );
  }
}
