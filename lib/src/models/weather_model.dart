import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'YOUR_OPENWEATHERMAP_API_KEY';
  final String city = 'Your_City_Name';

  Future<double> getCurrentTemperature() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['main']['temp'];
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
