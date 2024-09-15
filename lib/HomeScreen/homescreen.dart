import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism/glassmorphism.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> with SingleTickerProviderStateMixin {
  // ... [Keep all the existing variables and methods]
  String apiKey = 'fwTo7XbF1xxvIEDrU4wr2tvTU51lIfTF';
  double? latitude;
  double? longitude;

  String temperature = 'N/A';
  String humidity = 'N/A';
  String windSpeed = 'N/A';
  String dewPoint = 'N/A';
  String cloudCover = 'N/A';
  String visibility = 'N/A';
  String precipitationProbability = 'N/A';
  String locationName = 'Loading...';
  String heatWaveProbability = 'N/A'; // Variable for storing heat wave probability

  bool showHeatWaveAlert = false;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _getCurrentLocation();
    // Initialize the FlutterLocalNotificationsPlugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // ... [Keep the rest of the initState method]
  }
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
    _getAddressFromLatLong(position);
    _getWeatherData();
  }

  Future<void> _getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      locationName = '${place.locality}, ${place.country}';
    });
  }
  Future<void> _getWeatherData() async {
    if (latitude == null || longitude == null) return;

    final url = Uri.parse(
        'https://api.tomorrow.io/v4/weather/realtime?location=$latitude,$longitude&fields=temperature,humidity,windSpeed,dewPoint,cloudCover,visibility,precipitationProbability&units=metric&apikey=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          temperature = data['data']['values']['temperature'].toString();
          humidity = data['data']['values']['humidity'].toString();
          windSpeed = data['data']['values']['windSpeed'].toString();
          dewPoint = data['data']['values']['dewPoint'].toString();
          cloudCover = data['data']['values']['cloudCover'].toString();
          visibility = data['data']['values']['visibility'].toString();
          precipitationProbability = data['data']['values']['precipitationProbability'].toString();
        });
      }
    } catch (e) {
      setState(() {
        temperature = 'Error occurred: $e';
      });
    }
  }
  Future<void> heatWaveProb() async {
    if (latitude == null || longitude == null) return;

    final url = Uri.parse('https://heliosphere.up.railway.app/?lat=$latitude&long=$longitude');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final probability = data['probability'];

        // Store the heat wave probability with four decimal precision
        setState(() {
          heatWaveProbability = (probability * 100).toStringAsFixed(4); // Convert to percentage and format
        });

        // Send the notification with the heat wave probability
        _showHeatWaveNotification();
      }
    } catch (e) {
      setState(() {
        temperature = 'Error occurred: $e';
      });
    }
  }

  void _showHeatWaveAlert() {
    setState(() {
      showHeatWaveAlert = true;
    });

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        showHeatWaveAlert = false;
      });
    });

    // Call the heatWaveProb function to get the probability
    heatWaveProb();
  }

  Future<void> _showHeatWaveNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'heatwave_channel_id', 'Heat Wave Alerts',
      channelDescription: 'Channel for Heat Wave Alerts',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Heat Wave Alert',
      'There is a $heatWaveProbability% chance of a heat wave.',
      platformChannelSpecifics,
      payload: 'heatwave_payload',
    );
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ... [Keep all other existing methods]

  Widget _buildWeatherTile(IconData icon, String title, String value, String unit) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 180,
      borderRadius: 20,
      blur: 20,
      alignment: Alignment.center,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.1),
          Colors.white.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.5),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            '$value $unit',
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(locationName),
                  background: SvgPicture.network(
                    'https://www.svgrepo.com/show/530132/weather.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        '$temperature°C',
                        style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildWeatherTile(FontAwesomeIcons.water, 'Humidity', humidity, '%'),
                          _buildWeatherTile(FontAwesomeIcons.wind, 'Wind Speed', windSpeed, 'm/s'),
                          _buildWeatherTile(FontAwesomeIcons.tint, 'Dew Point', dewPoint, '°C'),
                          _buildWeatherTile(FontAwesomeIcons.cloud, 'Cloud Cover', cloudCover, '%'),
                          _buildWeatherTile(FontAwesomeIcons.eye, 'Visibility', visibility, 'km'),
                          _buildWeatherTile(FontAwesomeIcons.umbrella, 'Precipitation', precipitationProbability, '%'),
                        ],
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          _showHeatWaveAlert();
                          _animationController.forward(from: 0.0);
                        },
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_animation.value * 0.1),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Predict Heat Wave',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      if (showHeatWaveAlert)
                        AnimatedOpacity(
                          opacity: showHeatWaveAlert ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 500),
                          child: GlassmorphicContainer(
                            width: double.infinity,
                            height: 150,
                            borderRadius: 20,
                            blur: 20,
                            alignment: Alignment.center,
                            border: 2,
                            linearGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.orange.withOpacity(0.1),
                                Colors.orange.withOpacity(0.05),
                              ],
                            ),
                            borderGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.orange.withOpacity(0.5),
                                Colors.orange.withOpacity(0.5),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Heat Wave Prediction',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Based on current weather patterns, there\'s a $heatWaveProbability% chance of a heat wave today. Stay hydrated and avoid prolonged sun exposure.',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}