import 'package:flutter/material.dart';

import '../utlis/constents/img_constants.dart';
import '../utlis/ultimate_profile_zooming.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blueGrey,
      ),
      body: buildTabbedScreen()
    );
  }
}

/// Functional screen with Row & Column layout
Widget buildTabbedScreen() {
  final tabs = <Tab>[
    const Tab(text: "Home"),
    const Tab(text: "Search"),
    const Tab(text: "Profile"),
    const Tab(text: "Profile"),
    const Tab(text: "Profile"),
    const Tab(text: "Profile"),
    const Tab(text: "Profile"),
  ];

  final views = <Widget>[
    buildHomeView(),
    buildSearchView(),
    buildProfileView(),
  ];

  return DefaultTabController(
    length: tabs.length,
    child: Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Row ke andar TabBar
            Row(
              children: [
                Expanded(
                  child: TabBar(
                    tabs: tabs,
                    indicatorColor: Colors.teal,
                    labelColor: Colors.teal,
                    unselectedLabelColor: Colors.grey,
                  ),
                ),
              ],
            ),

            // Expanded Column part me TabBarView
            Expanded(
              child: TabBarView(children: views),
            ),
          ],
        ),
      ),
    ),
  );
}

/// --- Tab Views ---
Widget buildHomeView() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.home, size: 60),
        SizedBox(height: 10),
        Text("Home Screen"),
      ],
    ),
  );
}

Widget buildSearchView() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Search something..."),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.search),
          SizedBox(width: 8),
          Text("Search results will show here"),
        ],
      ),
    ],
  );
}

Widget buildProfileView() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.settings),
          SizedBox(width: 8),
          Text("Profile Settings"),
        ],
      ),
    ],
  );
}
