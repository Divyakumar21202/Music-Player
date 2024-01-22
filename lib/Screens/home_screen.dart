import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/widgets/music_player_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlay = false;
  AudioPlayer _musicPlayer = AudioPlayer();

  // AssetSource assetSource = AssetSource('music/mmusic.mp3');

  @override
  void initState() {
    super.initState();
    getMax();
  }

  void getMax() async {
    await _musicPlayer.setSourceUrl(url);
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

  // void filePicker() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['mp3'],
  //   );
  //   if (result != null) {
  //     _musicPlayer.play(
  //       DeviceFileSource(result.files.single.path!),
  //     );
  //   } else {
  //     print('User canceled the picker');
  //   }
  // }

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
      await _musicPlayer.play(
        UrlSource(
          url,
        ),
      );
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  String url =
      'https://d1dgwvpmn80wva.cloudfront.net/e8a20ab51a6124da899acdf35bfdc74b';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: primaryBackground),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: bottomNavigationBarColor,
          onTap: (val) {
            setState(() {
              currentIndex = val;
            });
          },
          selectedItemColor: accentColor, // Set the selected item color
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.widgets_rounded,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Playlist',
              icon: Icon(
                Icons.playlist_play_rounded,
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.transparent,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // filePicker();
                          },
                          child: Text(
                            'Play from Local Storage',
                          ),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: _musicPlayer.onPositionChanged,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          color: previousButtonColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          playPause();
                        },
                        icon: isPlay
                            ? const Icon(
                                Icons.play_arrow_rounded,
                                color: playButtonColor,
                              )
                            : const Icon(
                                Icons.pause_circle_filled_outlined,
                                color: pauseButtonColor,
                              ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          color: nextButtonColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
