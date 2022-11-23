import 'package:flutter/material.dart';
import 'package:medware/components/nav_bar.dart';
import 'package:medware/screens/main/home/screens.dart' as home;
import 'package:medware/screens/main/calendar/screens.dart' as calendar;
import 'package:medware/screens/main/profile/screens.dart' as profile;
import 'package:medware/screens/main/event/screens.dart' as event;
import 'package:medware/utils/shared_preference/shared_preference.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _curIndex = 0;
  int _role = SharedPreference.getUserRole();
  final List<Widget> _homeScreens = home.screens;
  final List<Widget> _calendarScreens = calendar.screens;
  final List<Widget> _profileScreens = profile.screens;
  final List<Widget> _eventScreens = event.screens;
  void setIndex(newIndex) => setState(() => _curIndex = newIndex);
  void addEventPressed() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _eventScreens[_role],
        ),
      );

  @override
  Widget build(BuildContext context) {
    print(_role);
    final List<Widget> screens = [
      _homeScreens[_role],
      _calendarScreens[_role],
      _profileScreens[_role],
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: IndexedStack(
        children: screens,
        index: _curIndex,
      ),
      bottomNavigationBar: SharedPreference.getIsAdmin()
          ? null
          : NavBar(
              curScreen: setIndex,
              fabPressed: addEventPressed,
            ),
    );
  }
}
