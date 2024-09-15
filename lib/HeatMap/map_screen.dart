import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heatmap & Weather Models'),
        backgroundColor: Color(0xFF1E3A8A), // Deep Blue background
      ),
      body: Text("Here flutter map")
    );
  }
}
