// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return Column(
      children: [
        Slider(
          
          max: max,
          activeColor: iconColor,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              value.toString(),
            ),
            Text(
              max.toString(),
            ),
          ],
        ),
      ],
    );
  }
}
