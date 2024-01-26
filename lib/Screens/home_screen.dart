import 'package:flutter/material.dart';
import 'package:music_player/constants/Screen%20List/screen_list.dart';
import 'package:music_player/constants/widgets/bottom_nav_bar.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onChangeBottom: (val) {
          index = val;
          setState(() {});
        },
      ),
      body: screenList[index],
    );
  }
}
