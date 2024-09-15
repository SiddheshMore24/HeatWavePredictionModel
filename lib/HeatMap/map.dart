import 'package:flutter/material.dart';

class IndiaWeatherMap extends StatelessWidget {
  final List<WeatherPoint> weatherPoints = [
    WeatherPoint(0.2, 0.3, WeatherType.sunny),
    WeatherPoint(0.5, 0.2, WeatherType.rainy),
    WeatherPoint(0.8, 0.4, WeatherType.cloudy),
    WeatherPoint(0.3, 0.6, WeatherType.stormy),
    WeatherPoint(0.6, 0.7, WeatherType.partlyCloudy),
    WeatherPoint(0.7, 0.8, WeatherType.sunny),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('India Weather Map'),
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[200]!, Colors.blue[50]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 400,
                child: Stack(
                  children: [
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/India_location_map.svg/800px-India_location_map.svg.png',
                      fit: BoxFit.contain,
                    ),
                    ...weatherPoints.map((point) => Positioned(
                      left: point.x * 300,
                      top: point.y * 400,
                      child: WeatherIcon(type: point.type),
                    )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Weather Conditions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: WeatherType.values.map((type) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      WeatherIcon(type: type, size: 24),
                      SizedBox(width: 4),
                      Text(type.toString().split('.').last),
                    ],
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherPoint {
  final double x;
  final double y;
  final WeatherType type;

  WeatherPoint(this.x, this.y, this.type);
}

enum WeatherType { sunny, rainy, cloudy, stormy, partlyCloudy }

class WeatherIcon extends StatelessWidget {
  final WeatherType type;
  final double size;

  WeatherIcon({required this.type, this.size = 32});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color color;

    switch (type) {
      case WeatherType.sunny:
        iconData = Icons.wb_sunny;
        color = Colors.yellow;
        break;
      case WeatherType.rainy:
        iconData = Icons.grain;
        color = Colors.blue;
        break;
      case WeatherType.cloudy:
        iconData = Icons.cloud;
        color = Colors.grey;
        break;
      case WeatherType.stormy:
        iconData = Icons.flash_on;
        color = Colors.deepPurple;
        break;
      case WeatherType.partlyCloudy:
        iconData = Icons.cloud_queue;
        color = Colors.lightBlue;
        break;
    }

    return Icon(iconData, color: color, size: size);
  }
}