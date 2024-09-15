import 'package:flutter/material.dart';
// import 'package:your_app/widgets/hero_section.dart';
// import 'package:your_app/widgets/quick_actions.dart';

import '../widgets/hero_sections.dart';
import '../widgets/quick_actions.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E3A8A), // Deep Blue background
      appBar: AppBar(
        backgroundColor: Color(0xFF1E3A8A),
        elevation: 0,
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(), // Dynamic banner with current temperature, heatwave alerts, AI predictions
            SizedBox(height: 20),
            QuickActions(), // Buttons for weather reports, health advisories, and emergency resources
          ],
        ),
      ),
    );
  }
}
