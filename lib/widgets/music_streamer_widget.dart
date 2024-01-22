import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/widgets/music_player_widget.dart';

class MusicStreamerWidget extends StatefulWidget {
  const MusicStreamerWidget({super.key});

  @override
  State<MusicStreamerWidget> createState() => _MusicStreamerWidgetState();
}

class _MusicStreamerWidgetState extends State<MusicStreamerWidget> {
   bool isPlay = false;
  AudioPlayer _musicPlayer = AudioPlayer();
  AssetSource assetSource = AssetSource('music/mmusic.mp3');

  @override
  void initState() {
    super.initState();
    getMax();
  }

  void getMax() async {
    await _musicPlayer.setSource(assetSource);
    print('source Setted');
    _musicPlayer.getDuration().then((value) {
      if (value == null) {
        print('value is null');
      }
      print(value!.inSeconds.toString());
      max = value.inSeconds.toDouble();
      setState(() {});
    });
  }

  double value = 0.0;
  double max = 0.0;

  int currentIndex = 0;
  void playPause() async {
    if (isPlay) {
      isPlay = false;
      await _musicPlayer.pause();
      setState(() {});
    } else {
      isPlay = true;
      await _musicPlayer.play(assetSource);
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  String url =
      'https://dl2.soundcloudmp3.org/api/download/eyJpdiI6ImVMZ1d4eFVsTDVXeXVQelZiMmFHd1E9PSIsInZhbHVlIjoiTFdsc1ZFYVF6WStKSTI1QVlDXC90cEErbHZhZzNiTDFBRmxDdjVWVFhGSGFDbmJ6XC9aYVV5enFXSUxoOUhnWG14Q2x0ZWVkUXFDWGFZeWp6TStyTWVRY2lTTDhJbDdsVUhxdWhPMTNWT3JLVT0iLCJtYWMiOiJiMDJjMDgzZjBiMDdlNjdlNjk2MmI5NTNjNTM2N2M4YTUzNTgyNTYzNjE1MGRiMjk3YWU3Yjc3YzNjMTI1NjA3In0=';

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
        stream: _musicPlayer.onPositionChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MusicPlayerWidget(
              onChanged: (val) {
                value = val;
                _musicPlayer.seek(
                  Duration(
                    seconds: val.toInt(),
                  ),
                );
                setState(() {});
              },
              max: max,
              musicPlayer: _musicPlayer,
              value: value.toInt(),
            );
          }
          if (snapshot.data != null) {
            if (snapshot.data!.inSeconds.toDouble() == max) {
              value = 0;
              _musicPlayer.seek(Duration.zero);
            }
          }
          return MusicPlayerWidget(
            max: max,
            onChanged: (val) {
              _musicPlayer.seek(Duration(
                seconds: val.toInt(),
              ));
              value = val;
              setState(() {});
            },
            musicPlayer: _musicPlayer,
            value: snapshot.data!.inSeconds.toInt(),
          );
        });
  }
}
