import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          label: "Weather Reports",
          color: Color(0xFFFF4500), // Sunset Orange
          onPressed: () {
            // Navigate to Weather Reports Screen
          },
        ),
        ActionButton(
          label: "Health Advisories",
          color: Color(0xFF00BFFF), // Sky Blue
          onPressed: () {
            // Navigate to Health Advisories Screen
          },
        ),
        ActionButton(
          label: "Emergency Resources",
          color: Color(0xFF32CD32), // Lime Green
          onPressed: () {
            // Navigate to Emergency Resources Screen
          },
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  ActionButton({required this.label, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
