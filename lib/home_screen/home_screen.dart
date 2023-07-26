import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import '../services/api response.dart';
import '../settings_screen/settings_screen.dart';
import '../widgets/widgets_screen.dart';

class home_screen extends StatefulWidget {
  final String city;
  home_screen({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  WeatherAPI _weatherAPI = WeatherAPI();
  String getCurrentDayAndTime() {
    var now = DateTime.now();
    String day =
        DateFormat('EEEE').format(now); // Format day (Monday, Tuesday, etc.)
    String time =
        DateFormat('h:mm a').format(now); // Format time (7:30 AM / PM)
    return '$day $time';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.1,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context)
                  .iconTheme
                  .color, // Icon color based on theme
            ),
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'settings',
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
        iconTheme: IconThemeData(
          color: Theme.of(context).appBarTheme.iconTheme?.color,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: _weatherAPI.GetApiData(widget.city.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading spinner while waiting for data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                // Display an error message for city not found or data unavailable
                return Center(
                  child: Text(
                    'City not found or data unavailable',
                    style: TextStyle(fontSize: 30),
                  ),
                );
              } else {
                var weatherData = snapshot.data!;
                var icon = weatherData.weather?[0].icon.toString();
                var sunrise = weatherData.sys?.sunrise;
                var windSpeed = weatherData.wind?.speed;
                var temp = weatherData.main?.temp;

                if (sunrise != null) {
                  DateTime sunriseDateTime =
                      DateTime.fromMillisecondsSinceEpoch(
                    (sunrise).toInt() * 1000,
                  );
                  String formattedSunriseTime =
                      DateFormat('HH:mm').format(sunriseDateTime);

                  return Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        weatherData.name.toString(),
                        style: TextStyle(fontSize: 40),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getCurrentDayAndTime(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                      Image.network(
                        'https://openweathermap.org/img/wn/$icon@2x.png',
                        height: 300,
                        fit: BoxFit.fill,
                        width: 300,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${temp?.toString().substring(0, 2)}°C',
                        style: TextStyle(fontSize: 25),
                      ),
                      Spacer(),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            currentweather(WeatherIcons.sunset, 'SUNRISE',
                                formattedSunriseTime),
                            SizedBox(width: 5),
                            VerticalDivider(indent: 30, endIndent: 30),
                            currentweather(WeatherIcons.thermometer, 'WIND',
                                '${windSpeed?.round() ?? ''}m/s'),
                            SizedBox(width: 5),
                            VerticalDivider(indent: 30, endIndent: 30),
                            currentweather(Icons.speed, 'TEMPARATURE',
                                '${temp?.toString().substring(0, 2)}°'),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  // Handle the case when sunrise data is null
                  return Center(
                    child: Text(
                      'Wrong City name ',
                      style: TextStyle(fontSize: 30),
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
