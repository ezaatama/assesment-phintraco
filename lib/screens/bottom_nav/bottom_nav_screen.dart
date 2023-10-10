import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:phintraco_assesment/screens/absen/absensi_screen.dart';
import 'package:phintraco_assesment/tabs/homescreen.dart';
import 'package:phintraco_assesment/tabs/profile_screen.dart';
import 'package:phintraco_assesment/utils/constant.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _screens() {
    return [const HomeScreen(), const AbsensiScreen(), const ProfileScreen()];
  }

  List<PersistentBottomNavBarItem> _navbarItem() {
    return [
      PersistentBottomNavBarItem(
          title: "Home",
          textStyle: WHITE_TEXT_STYLE,
          activeColorPrimary: ColorUI.WHITE,
          inactiveColorPrimary: ColorUI.WHITE.withOpacity(.40),
          icon: const Icon(
            Icons.home,
            color: ColorUI.WHITE,
          ),
          inactiveIcon: Icon(
            Icons.home,
            color: ColorUI.WHITE.withOpacity(.40),
          )),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.access_alarm_outlined,
            color: ColorUI.WHITE,
          ),
          inactiveIcon: Icon(
            Icons.access_alarm_outlined,
            color: ColorUI.WHITE.withOpacity(.80),
          )),
      PersistentBottomNavBarItem(
          title: "Profile",
          textStyle: WHITE_TEXT_STYLE,
          activeColorPrimary: ColorUI.WHITE,
          inactiveColorPrimary: ColorUI.WHITE.withOpacity(.40),
          icon: const Icon(
            Icons.person,
            color: ColorUI.WHITE,
          ),
          inactiveIcon: Icon(
            Icons.person,
            color: ColorUI.WHITE.withOpacity(.40),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _screens(),
      items: _navbarItem(),
      controller: _controller,
      backgroundColor: ColorUI.PRIMARY_COLOR,
      decoration: NavBarDecoration(borderRadius: BorderRadius.circular(1)),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
