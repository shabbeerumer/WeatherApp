import 'dart:async';
import 'package:flutter/material.dart';
import '../user_search_city_screen/user_search_city_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use the Timer constructor with Duration parameter for delay
    Timer(Duration(seconds: 10), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WeatherScreen()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'image/1779940.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Weather App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
