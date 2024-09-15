import 'package:flutter/material.dart';

class AlertSettingsScreen extends StatefulWidget {
  @override
  _AlertSettingsScreenState createState() => _AlertSettingsScreenState();
}

class _AlertSettingsScreenState extends State<AlertSettingsScreen> {
  double _temperatureThreshold = 35.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alert Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Set Temperature Threshold", style: TextStyle(fontSize: 18)),
            Slider(
              value: _temperatureThreshold,
              min: 20,
              max: 50,
              divisions: 30,
              label: "$_temperatureThreshold°C",
              onChanged: (value) {
                setState(() {
                  _temperatureThreshold = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the threshold to the database or local storage
              },
              child: Text("Save Settings"),
            ),
          ],
        ),
      ),
    );
  }
}
