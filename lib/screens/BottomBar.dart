import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rickandmorty/screens/CharactersPage.dart';
import 'package:rickandmorty/screens/EpisodePage.dart';
import 'package:rickandmorty/screens/LocationPage.dart';
import 'package:rickandmorty/screens/SettingsPage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List _widgetOptions = [
    const CharactersPage(),
    const LocationPage(),
    const EpisodePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/characters_icon.svg",
            colorFilter: ColorFilter.mode(selectedIndex==0 ? Color(0xff43D049): Color(0xff5B6975) , BlendMode.srcIn)),
            label: "Character",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/location_icon.svg",
            colorFilter: ColorFilter.mode(selectedIndex==1 ? Color(0xff43D049): Color(0xff5B6975) , BlendMode.srcIn)),
            label: "Locations",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/episode_icon.svg",
            colorFilter: ColorFilter.mode(selectedIndex==2 ? Color(0xff43D049): Color(0xff5B6975) , BlendMode.srcIn)),
            label: "Episodes",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/settings_icon.svg",
            colorFilter: ColorFilter.mode(selectedIndex==3 ? Color(0xff43D049): Color(0xff5B6975) , BlendMode.srcIn)),
            label: "Settings",
          ),
        ],
        backgroundColor: Color(0xff152A3A),
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0xff43D049),
        unselectedItemColor: Color(0xff5B6975),
      ),
    );
  }
}
