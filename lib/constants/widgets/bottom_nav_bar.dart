import 'package:flutter/material.dart';
import 'package:music_player/constants/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: primaryBackground,
      selectedItemColor: iconColor,
      unselectedItemColor: Colors.white,
      currentIndex: index,
      onTap: (val) {
        index = val;
        setState(() {});
      },
      items: const [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.repeat,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.music_note_rounded,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.heart_broken,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.queue_music_outlined,
          ),
        ),
      ],
    );
  }
}
