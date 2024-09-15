import 'package:climate_resilience_app/HeatMap/map_screen.dart';
import 'package:climate_resilience_app/HomeScreen/homescreen.dart';
import 'package:climate_resilience_app/Insights/datadriveninsights.dart';
import 'package:climate_resilience_app/Settings/settings.dart';
import 'package:climate_resilience_app/src/screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../Alert/alertnNotify.dart';
import '../HeatMap/map_fetching.dart';
// import 'package:your_app/screens/home_screen.dart';
// import 'package:your_app/screens/maps_screen.dart';
// import 'package:your_app/screens/insights_screen.dart';
// import 'package:your_app/screens/alerts_screen.dart';
// import 'package:your_app/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    WeatherScreen(),
    // WeatherMapScreen(),
    DataDrivenInsights(),
    AlertSettingsScreen(),
    SettingsScreen(),




    // MapsScreen(),
    // InsightsScreen(),
    // AlertsScreen(),
    // SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Color(0xFF2C3E50), // Charcoal Gray background
        selectedItemColor: Color(0xFFFFD700), // Gold for active icons
        unselectedItemColor: Color(0xFFD1D5DB), // Cool Gray for inactive icons
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
