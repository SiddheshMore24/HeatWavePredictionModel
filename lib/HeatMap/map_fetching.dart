import 'package:flutter/material.dart';

class WeatherMapScreen extends StatelessWidget {
  final String apiKey = 'b344c441c4c1bb0ee1b1ec7dcbc846ea';
  final String layerType = 'TA2'; // Air temperature layer
  final int zoom = 5; // Zoom level

  @override
  Widget build(BuildContext context) {
    // Valid x, y coordinates for India at zoom level 5
    // Coordinates typically range from 0 to 2^zoom - 1
    final int x = 15; // Example x coordinate
    final int y = 7;  // Example y coordinate

    String url = 'https://tile.openweathermap.org/map/$layerType/$zoom/$x/$y.png?appid=$apiKey';

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Map of India'),
      ),
      body: Center(
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
