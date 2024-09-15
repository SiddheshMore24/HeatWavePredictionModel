import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:your_app/services/weather_service.dart';

import '../models/weather_model.dart';

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFF4500), // Sunset Orange for key stats
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animated icon
          Lottie.asset('assets/lottie/sun_heatwaves.json', height: 100),

          SizedBox(height: 10),

          // Current Temperature
          FutureBuilder(
            future: WeatherService().getCurrentTemperature(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error fetching temperature");
              } else {
                return Text(
                  "Current Temperature: ${snapshot.data}°C",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            },
          ),

          SizedBox(height: 10),

          // Heatwave Alerts (Placeholder for now)
          Text(
            "Heatwave Alert: Moderate Risk",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),

          SizedBox(height: 10),

          // AI Predictions (Placeholder for now)
          Text(
            "AI Prediction: 35°C in the next 3 days",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
